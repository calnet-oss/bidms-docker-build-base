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

RUN rm -rf /core

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
