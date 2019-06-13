FROM ubuntu:latest

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install openssh-server telnetd xinetd && echo "root:root"|chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN touch /etc/xinetd.d/telnet && printf "service telnet\n{\ndisable = no\nflags = REUSE\nsocket_type = stream\nwait = no\nuser = root\nserver = /usr/sbin/in.telnetd\nlog_on_failure += USERID\n}" > /etc/xinetd.d/telnet && printf "pts/0\npts/1\npts/2\npts/3\npts/4\npts/5\npts/6\npts/7\npts/8\npts/9" >> /etc/securetty

RUN sed -i 's/LOGIN_TIMEOUT		60/LOGIN_TIMEOUT 600/g' /etc/login.defs

CMD service ssh start && service xinetd start && /bin/bash

#CMD /bin/bash
