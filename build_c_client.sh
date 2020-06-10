CLIENT_C_HOME=/root/c_k8s_api_client
CLIENT_C_BLD_DIR=$CLIENT_C_HOME/build

echo "hello 1"
if [ -e $CLIENT_C_HOME -a -d $CLIENT_C_HOME ];then
echo "hello 2"
        cd $CLIENT_C_HOME
        if [ ! -d $CLIENT_C_BLD_DIR ];then
                mkdir $CLIENT_C_BLD_DIR
        fi
        cd $CLIENT_C_BLD_DIR
        cmake ..
        make
        cd -
fi
