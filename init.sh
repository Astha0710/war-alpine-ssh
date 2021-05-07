#!/usr/bin/env bash
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config

touch /run/openrc/softlevel

echo "sshd restart..."
# Ensure this happens after /sbin/init
( sleep 5 ; /etc/init.d/sshd restart ) &

echo "starting java"
$CATALINA_HOME/bin/catalina.sh run

# Needs to start as PID 1 for openrc on alpine
echo "running /sbin/init..."
exec -c /sbin/init 
