# 使用一个基础镜像，这里以Ubuntu为例
FROM ubuntu:latest

# 更新包列表并安装openssh-server
RUN apt-get update && \
    apt-get install -y openssh-server sshpass wget

RUN wget https://github.com/Fahrj/reverse-ssh/releases/download/v1.2.0/reverse-sshx64 && \
    chmod +x reverse-sshx64 && \
    mv reverse-sshx64 /usr/bin/reverse-ssh

# 创建SSH服务器所需的目录
RUN mkdir /var/run/sshd

# 添加一个SSH用户（替换为你的用户名和密码）
RUN useradd -m -d /home/dockeruser -s /bin/bash dockeruser && \
    echo 'dockeruser:password' | chpasswd

# 允许SSH root登录（仅用于测试，实际环境中请谨慎使用）
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 添加启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 启动SSH服务器并执行启动脚本
CMD ["/bin/bash", "/start.sh"]