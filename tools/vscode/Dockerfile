FROM ubuntubase:latest

ENV DEBIAN_FRONTEND noninteractive
ENV LANG ja_JP.UTF-8

RUN apt update && apt install -y \
    curl \
    gpg \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    git \
    zip \
    unzip \
    wget \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt update && apt install -y \
    code \
    google-chrome-stable \
    && apt-get clean \
    && rm microsoft.gpg \
    && rm -rf /var/lib/apt/lists/*

