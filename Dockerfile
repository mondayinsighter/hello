FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y openssh-server sshpass wget htop curl unzip net-tools less python3-pip git

RUN wget https://github.com/Fahrj/reverse-ssh/releases/download/v1.2.0/reverse-sshx64 && \
    chmod +x reverse-sshx64 && \
    mv reverse-sshx64 /usr/bin/reverse-ssh

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

RUN git clone https://github.com/nemo-wq/AWS-IAM-Permissions-Scanner.git && cd AWS-IAM-Permissions-Scanner && pip3 install -r requirements.txt

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl

RUN mkdir /var/run/sshd

RUN useradd -m -d /home/dockeruser -s /bin/bash dockeruser && \
    echo 'dockeruser:password' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]