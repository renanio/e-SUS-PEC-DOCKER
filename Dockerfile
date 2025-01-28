FROM archlinux:latest

# Atualizar os pacotes e instalar systemd, OpenVPN, JDK, OpenSSH e timezone
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm openvpn jdk-openjdk systemd tzdata openssh \
    && ln -sf /usr/share/zoneinfo/America/Porto_Velho /etc/localtime \
    && echo "America/Porto_Velho" > /etc/timezone

# Habilitar e configurar o SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "root:SUA_SENHA_ROOT" | chpasswd \
    && sed -i 's/#Port 22/Port 53032/' /etc/ssh/sshd_config \
    && sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && systemctl enable sshd

# Expor as portas necessárias
EXPOSE 8080 53032

# Definir o sinal de parada e comando inicial para o container
STOPSIGNAL SIGRTMIN+3
CMD ["/usr/sbin/init"]
