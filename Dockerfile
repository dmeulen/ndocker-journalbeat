FROM ubuntu:latest
MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV JOURNALBEAT_VERSION=7.1.0 \
  APT_ADD="curl" \
  APT_ADD_PERM=""

RUN apt-get update && \
  apt-get install -y ${APT_ADD} ${APT_ADD_PERM} && \
  curl -fsSL https://artifacts.elastic.co/downloads/beats/journalbeat/journalbeat-${JOURNALBEAT_VERSION}-linux-x86_64.tar.gz -o /tmp/journalbeat.tar.gz && \
  cd /tmp/ && \
  mkdir -p /opt/ndocker/bin && \
  mkdir -p /opt/ndocker/etc && \
  tar xzf /tmp/journalbeat.tar.gz -C /opt/ndocker/bin && \
  ln -s /opt/ndocker/bin/journalbeat-${JOURNALBEAT_VERSION}-linux-x86_64 /opt/ndocker/bin/journalbeat && \
  chmod 755 /opt/ndocker/bin/journalbeat* && \
  chown root:root /opt/ndocker/bin/journalbeat* && \
  rm -rf /tmp/filebeat* && \
  apt-get purge -y ${APT_ADD} && \
  apt-get clean

COPY rootfs/ /

CMD ["/init/run.sh"]
