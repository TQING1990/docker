FROM centos:7

# 更新
RUN yum -y update

# 安装
# ssh 需要
RUN yum -y install passwd
RUN yum -y install openssh-server

# skynet 支持 https 需要
RUN yum -y install openssl

# 编译 skynet 需要
RUN yum -y install gcc
RUN yum -y install readline-devel
RUN yum -y install openssl-devel

RUN yum clean all

# 配置 ssh
RUN sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/^HostKey/#HostKey/g' /etc/ssh/sshd_config
RUN sed -i 's/\([#]\)\(HostKey.*rsa\)/\2/g' /etc/ssh/sshd_config
RUN (mkdir -p /root/.ssh/; \
     echo "StrictHostKeyChecking=no" > /root/.ssh/config; \
     echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config)
# 配置 sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
# 指定root密码
RUN /bin/echo 'root:yourpassword'|chpasswd

# ssh 端口
EXPOSE 22

COPY boot.sh /root/

WORKDIR /opt/app

ENTRYPOINT ["/root/boot.sh"]
