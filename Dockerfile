FROM tomcat:9.0-alpine

ENV SSH_PORT 2222

COPY init.sh /opt/startup/init.sh

ADD sample*.war $CATALINA_HOME/webapps/sample.war

RUN apk add --update openssh bash openrc \
     && openrc \
     && echo "root:Docker!" | chpasswd \
     && chmod 755 /opt/startup/init.sh

VOLUME /sys/fs/cgroup

COPY sshd_config /etc/ssh/

EXPOSE 8080 2222
ENTRYPOINT ["/opt/startup/init.sh"]
