FROM ubuntu
RUN apt update -y && apt install -yq --no-install-recommends \
    apt-utils \
    iputils-ping \
    openssh-server \
    wget \
    nano \
    net-tools \
    sudo \
    curl \
    python3 \
    unzip \
    dos2unix \
    software-properties-common 

  
#indicamos el timezone
ARG TZ=Europe/Madrid
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV USUARIO=jj
ENV PASSWD=jj

RUN useradd -rm -d /home/$USUARIO -s /bin/bash $USUARIO 
RUN echo $USUARIO:$PASSWD | chpasswd
RUN echo $USUARIO "ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENTRYPOINT service ssh start && service ssh restart && tail -f /dev/null