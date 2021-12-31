FROM ubuntu:20.04
# Args
ARG OUTSIDE_MAVEN=apache-maven-3.8.4
ARG OUTSIDE_JDK=jdk-11.0.13.8
# Copy files into image
COPY ${OUTSIDE_MAVEN} /opt/apache-maven
COPY ${OUTSIDE_JDK} /opt/jdk
COPY config/sources.list /opt/sources.list
COPY config/maven-settings.xml /opt/settings.xml
COPY ulimit/limits.conf /etc/security/limits.conf
COPY ulimit/sysctl.conf /etc/sysctl.conf
# Prepare image environment
USER root
RUN mkdir -p /opt/apache-maven-repository \
    && cp /opt/sources.list /etc/apt/sources.list \
    && cp /opt/settings.xml /opt/apache-maven/conf/settings.xml \
    && apt-get update \
    && apt-get upgrade \
    && apt-get autoremove \
    && apt-get autoclean \
    && apt-get install -y tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -vf /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata
# Prepare environment variables
ENV LANG en_US.utf8
ENV MAVEN_HOME /opt/apache-maven
ENV JAVA_HOME /opt/jdk
ENV JAVA_VERSION=11.0.13
ENV PATH "${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"
