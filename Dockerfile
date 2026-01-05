FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ARG flutter_version=3.10.6

ARG UID=1000
RUN useradd -m -s /bin/bash -u ${UID} user

RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils \
    libglu1-mesa \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    && git clone https://github.com/flutter/flutter.git /usr/local/flutter
    # && curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_version}-stable.tar.xz \
    # && tar xf ./flutter_linux_${flutter_version}-stable.tar.xz \
    # && mv flutter /opt/ \
    # && chown -R user /opt/flutter

ENV PATH=$PATH:/usr/local/flutter/bin
RUN flutter channel stable
# ENV PATH /opt/flutter/bin:$PATH

# Install Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
# ENV PATH=$PATH:/usr/local/flutter/bin

WORKDIR /app
COPY . /app

RUN flutter pub get
RUN flutter build bundle

CMD ["flutter", "run"]
