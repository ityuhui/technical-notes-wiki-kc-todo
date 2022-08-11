#! /usr/bin/env bash

set -x

op=$1

# Turn colors in this script off by setting the NO_COLOR variable in your
# environment to any value:
#
# $ NO_COLOR=1 test.sh
NO_COLOR=${NO_COLOR:-""}
if [ -z "$NO_COLOR" ]; then
  header=$'\e[1;33m'
  reset=$'\e[0m'
else
  header=''
  reset=''
fi

header_text () {
  echo "$header$*$reset"
}

K8S_VERSION=${K8S_VERSION:-v1.24.0@sha256:0866296e693efe1fed79d5e6c7af8df71fc73ae45e3679af05342239cdc5bc8e}
: ${MY_NAMESPACE:=my-namespace}
: ${KEEP_PROXY:=true}

registry_delete() {
  docker network disconnect kind kind-registry
  docker kill kind-registry
  docker rm -f kind-registry
  if [ "${KEEP_PROXY}" != true ]; then
    docker network disconnect kind kind-registry-proxy
    docker kill kind-registry-proxy
    docker rm -f kind-registry-proxy
  fi
}

registry_create() {
  # The registry is for the locally created images and helm charts
  running="$(docker inspect -f '{{.State.Running}}' "kind-registry" 2>/dev/null || true)"
  if [ "${running}" != 'true' ]; then
    docker run \
      -d --restart=always -p "5000:5000" --name "kind-registry" \
      --network kind \
      -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
      registry:2
  fi
  # The proxy registry caches public images and helps to circumvent the
  # docker hub download limits by allowing to set a separate docker hub login.
  proxy_running="$(docker inspect -f '{{.State.Running}}' "kind-registry-proxy" 2>/dev/null || true)"
  if [ "${proxy_running}" != 'true' ]; then
    if [ -v DOCKERHUB_USERNAME ]; then
      echo "Creating proxy with user login"
      docker run \
          -d --restart=always -p "5001:5000" --name "kind-registry-proxy" \
          --network kind \
          -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 \
          -e REGISTRY_PROXY_REMOTEURL="https://registry-1.docker.io" \
          -e REGISTRY_PROXY_USERNAME=${DOCKERHUB_USERNAME} \
          -e REGISTRY_PROXY_PASSWORD=${DOCKERHUB_PASSWORD} \
          registry:2
    else
      echo "Creating proxy with anonymous login"
      docker run \
          -d --restart=always -p "5001:5000" --name "kind-registry-proxy" \
          --network kind \
          -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 \
          -e REGISTRY_PROXY_REMOTEURL="https://registry-1.docker.io" \
          registry:2
    fi
  fi
}

kind_delete() {
  kind delete cluster --name $1
}

kind_create() {
  kind create cluster --name $1 \
    -v 4 --retain --wait=0s \
    --config ./$2 \
    --image=kindest/node:$K8S_VERSION
  for node in $(kind get nodes --name $1); do
    kubectl annotate node "${node}" "tilt.dev/registry=localhost:5000" --context kind-${1}
  done
}

# Taken from https://kind.sigs.k8s.io/docs/user/ingress/
install_nginx_ingress() {
        kubectl config use-context kind-"$1"
        kubectl create ns "$MY_NAMESPACE" || true

        echo Install ingress-nginx
        # Using v1.0.3 because of https://github.com/kubernetes/ingress-nginx/issues/7810
        kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.3/deploy/static/provider/kind/deploy.yaml
        kubectl wait --namespace ingress-nginx \
          --for=condition=ready pod \
          --selector=app.kubernetes.io/component=controller \
          --timeout=90s
        kubectl apply -f ingress-nginx.yaml -n "$MY_NAMESPACE"
}

case "$op" in
cleanup)
  header_text "Uninstalling kind cluster"
  registry_delete || true
  kind_delete kind || true
  kind_delete control || true
  ;;
multi)
  header_text "Installing kind multi-cluster"
  kind_create kind kind-kind-config.yaml &
  kind_create control kind-control-config.yaml &
  wait
  registry_create
  install_nginx_ingress control &
  ;;
*)
  header_text "Installing kind cluster"
  kind_create kind kind-kind-config.yaml
  registry_create
  ;;
esac
