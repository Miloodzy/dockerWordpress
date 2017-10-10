#!/bin/bash
ipAddress=$(echo `ifconfig wlp3s0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`)

if [ -z "$ipAddress" ]; then
	ipAddress=$(echo `ifconfig enp0s3 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`)	
fi

echo $ipAddress
