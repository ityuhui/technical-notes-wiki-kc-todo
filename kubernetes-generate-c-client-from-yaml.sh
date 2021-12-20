mvn clean package

echo "begin to generate..."

sleep 5

java -jar modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /root/c/kubernetes/swagger.json   -g c    -o ../kubernetes-client-c --skip-validate-spec
--type-mappings "int-or-string=IntOrString"

echo "generated."
