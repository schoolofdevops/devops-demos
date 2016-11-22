#!/bin/bash
cd /docker/jenkins_home/
docker build -t tomcatapp .
#Username and Password for local docker registry
USER="admin"
PASS="1nitCr0n"
#Start of expect script
expect <<EOF
spawn docker login https://initcronregistry.org
#Turn logging off
log_user 0
expect "Username:"
send "$USER\r"
expect "Password:"
send "$PASS\r"
#Tag the custom image
spawn docker tag tomcatapp initcronregistry.org/tomcatapp
#Push the image
spawn docker push initcronregistry.org/tomcatapp
#Turn logging on
log_user 1
expect eof
EOF
if docker service ls 2> /dev/null | grep -q -i "tomapp"; then
        echo "Service is already running"
else
        docker service create --replicas 6 --publish 8080:8080 --log-driver=syslog  --log-opt syslog-address=tcp://192.168.0.53:5000 --name tomapp initcronregistry.org/tomcatapp
fi
