FROM centos:7

# 更新
RUN yum -y update

# 安装
RUN yum -y install passwd, openssh-server; yum clean all

# 修改配置文件
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
RUN /bin/echo 'root:password'|chpasswd

# 端口
EXPOSE 22

CMD ["/bin/sbin/sshd", "-D"]