FROM ubuntu:22.04

RUN apt update -y && apt upgrade -y
RUN apt install -y \
    sudo \
    curl \
    git \
    default-jre \
    python3 \
    python3-pip \
    unzip \
    vim

# awscli
RUN find /usr/lib/python* -type f -name EXTERNALLY-MANAGED -delete
RUN pip3 install awscli

# leiningen
RUN curl -L -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x lein
RUN mv lein /usr/local/bin
RUN lein

# clojure
RUN curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
RUN chmod +x linux-install.sh
RUN ./linux-install.sh

# switch user
ARG USERNAME=sam
RUN useradd -ms /bin/bash $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

