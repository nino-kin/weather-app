FROM vscode:latest

ENV DEBIAN_FRONTEND noninteractive

ARG studio_version=2020.3.1.25 # Android Studioのバージョンを指定
ARG flutter_version=3.10.6
RUN apt update && apt install -y \
    libglu1-mesa \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    && curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_version}-stable.tar.xz \
    && tar xf ./flutter_linux_${flutter_version}-stable.tar.xz \
    && curl -LO https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${studio_version}/android-studio-${studio_version}-linux.tar.gz \
    && tar xf ./android-studio-${studio_version}-linux.tar.gz \
    && mv flutter /opt/ \
    && chown -R user /opt/flutter \
    && mv android-studio /opt/ \
    && ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android_studio \
    && usermod -a -G plugdev user
ENV PATH /opt/flutter/bin:$PATH
ENV CHROME_EXECUTABLE /usr/bin/google-chrome

