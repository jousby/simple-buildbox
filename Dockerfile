FROM frolvlad/alpine-glibc:alpine-3.7

LABEL maintainer="James Ousby <jousby@gmail.com>"

ENV SDKMAN_DIR=/opt/sdkman

# The below is using Sdkman (http://sdkman.io) to manage the installation of jvm related build tools. 
# The version numbers listed here are sdkman sdk version tags.  Unfortunately to get a list of valid tags to
# enter here you need a working installation of sdkman installed somewhere ('sdk list java'). 
# TODO Once this image is published on dockerhub, update with command to use this image to get
# latest tags. 
# The following page lists other possible tools you can install (http://sdkman.io/sdks.html).
ENV JAVA_VERSION=8u152-zulu
ENV GRADLE_VERSION=4.4.1
ENV MAVEN_VERSION=3.5.2
ENV SBT_VERSION=1.1.0

# Install required packages for docker, python, aws-cli and sdkman
# Configure docker to start on boot
RUN apk upgrade --update \
    && apk add --no-cache --update \
        bash \
        ca-certificates \
        curl \
        docker \
        groff \
        less \
        libstdc++ \
        openssl \
        openrc \
        python \
        py-pip \
        unzip \
        zip \
    && update-ca-certificates \
    && rc-update add docker boot

# Install sdkman (simple way to add required jvm build tooling)
# Install desired JVM build tools (for a full list of sdkman managed tools see http://sdkman.io/sdks.html)
RUN curl -s "https://get.sdkman.io" | bash \
    && rm -rf /var/lib/apt/lists/* \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=true" >> $SDKMAN_DIR/etc/config \
    && bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install java ${JAVA_VERSION}" \
    && bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install gradle ${GRADLE_VERSION}" \
    && bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install maven ${MAVEN_VERSION}" \
    && bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install sbt ${SBT_VERSION}"

# Install AWS Command Line Interface
RUN pip install awscli

ENTRYPOINT /bin/bash