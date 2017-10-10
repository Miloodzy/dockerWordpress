#!/bin/bash
ipAddress=$(echo `ifconfig wlp3s0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`)

if [ -z "$ipAddress" ]; then
        ipAddress=$(echo `ifconfig enp0s3 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`)
fi

user=$1
pass=$2
mail=$3

echo ########### Suppress Container Running ##########
dock=$(docker ps -q)
docker stop $dock

echo "####### Build Dockerfile #########"
#echo "docker build -t wordpresscontainer --build-arg ip=$ipAddress --build-arg user=$user --build-arg pass=$pass --build-arg mail=$mail ."

docker build -t wordpresscontainer --build-arg ip=$ipAddress --build-arg user=$user --build-arg pass=$pass --build-arg mail=$mail .

echo "########## Run Docker Container ########"
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -d wordpresscontainer 
