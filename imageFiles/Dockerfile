#
# Copyright (c) 2017, Regents of the University of California and
# contributors.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
FROM bidms/debian_base

ARG APT_PROXY_URL=
RUN if [ ! -z "$APT_PROXY_URL" ]; then echo "Acquire::http::Proxy \"$APT_PROXY_URL\";" > /etc/apt/apt.conf.d/00aptproxy; else echo "not using apt proxy"; fi

RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get -y install git openjdk-8-jdk-headless maven \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/*

COPY tmp_passwords/ /tmp/tmp_passwords/
COPY root/ /root/
RUN chmod 600 /root/.m2/settings.xml /root/.gradle/gradle.properties
RUN /tmp/tmp_passwords/replaceBidmsBuildPw.sh /root/.m2/settings.xml \
  && /tmp/tmp_passwords/replaceBidmsBuildPw.sh /root/.gradle/gradle.properties

# Download Gradle wrapper ahead of time so each container run doesn't try to
# re-download it (TODO: Would be better to use a squid/varnish caching proxy
# server running within the docker network [perhaps on tomcat-dev].)
RUN mkdir -p /root/.gradle/wrapper/dists/gradle-4.0-bin/3p92xsbhik5vmig8i90n16yxc \
  && wget "https://services.gradle.org/distributions/gradle-4.0-bin.zip" -O /root/.gradle/wrapper/dists/gradle-4.0-bin/3p92xsbhik5vmig8i90n16yxc/gradle-4.0-bin.zip

RUN mkdir -p /root/.gradle/wrapper/dists/gradle-3.4.1-bin/71zneekfcxxu7l9p7nr2sc65s \
  && wget "https://services.gradle.org/distributions/gradle-3.4.1-bin.zip" -O /root/.gradle/wrapper/dists/gradle-3.4.1-bin/71zneekfcxxu7l9p7nr2sc65s/gradle-3.4.1-bin.zip

RUN mkdir -p /root/.gradle/wrapper/dists/gradle-3.4.1-all/c3ib5obfnqr0no9szq6qc17do \
  && wget "https://services.gradle.org/distributions/gradle-3.4.1-all.zip" -O /root/.gradle/wrapper/dists/gradle-3.4.1-all/c3ib5obfnqr0no9szq6qc17do/gradle-3.4.1-all.zip

RUN rm -rf /core /tmp/tmp_passwords

COPY etc/container/ /etc/container/
ENTRYPOINT ["/etc/container/build-entrypoint.sh", "interactive"]

ARG TOMCAT_VOLUME=/var/lib/tomcat8
ARG LOCAL_BIDMS_USER_FRONTEND_TOMCAT_PORT=8340
ARG LOCAL_BIDMS_ADMIN_FRONTEND_TOMCAT_PORT=8341
ARG LOCAL_BIDMS_RESTAPI_FRONTEND_TOMCAT_PORT=8342
ARG LOCAL_BIDMS_BACKEND_TOMCAT_PORT=8343
ARG LOCAL_AMQ_TOMCAT_PORT=8344

RUN echo "TOMCAT_VOLUME=$TOMCAT_VOLUME" >> /etc/container/container.properties \
  && echo "LOCAL_BIDMS_USER_FRONTEND_TOMCAT_PORT=$LOCAL_BIDMS_USER_FRONTEND_TOMCAT_PORT" >> /etc/container/container.properties \
  && echo "LOCAL_BIDMS_ADMIN_FRONTEND_TOMCAT_PORT=$LOCAL_BIDMS_ADMIN_FRONTEND_TOMCAT_PORT" >> /etc/container/container.properties \
  && echo "LOCAL_BIDMS_RESTAPI_FRONTEND_TOMCAT_PORT=$LOCAL_BIDMS_RESTAPI_FRONTEND_TOMCAT_PORT" >> /etc/container/container.properties \
  && echo "LOCAL_BIDMS_BACKEND_TOMCAT_PORT=$LOCAL_BIDMS_BACKEND_TOMCAT_PORT" >> /etc/container/container.properties \
  && echo "LOCAL_AMQ_TOMCAT_PORT=$LOCAL_AMQ_TOMCAT_PORT" >> /etc/container/container.properties
