FROM ubuntu:latest
MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV JOURNALBEAT_VERSION=7.1.0 \
  APT_ADD="curl" \
  APT_ADD_PERM=""

RUN apt-get update && \
  apt-get install -y ${APT_ADD} ${APT_ADD_PERM} && \
  curl -fsSL https://artifacts.elastic.co/downloads/beats/journalbeat/journalbeat-${JOURNALBEAT_VERSION}-linux-x86_64.tar.gz -o /tmp/journalbeat.tar.gz && \
  cd /tmp/ && \
  mkdir -p /opt/ndocker && \
  tar xzf /tmp/journalbeat.tar.gz -C /opt/ndocker && \
  ln -s /opt/ndocker/journalbeat-${JOURNALBEAT_VERSION}-linux-x86_64 /opt/ndocker/journalbeat && \
  chown -R root:root /opt/ndocker/journalbeat* && \
  rm -rf /tmp/filebeat* && \
  apt-get purge -y ${APT_ADD} && \
  apt-get clean

COPY rootfs/ /

CMD ["/init/run.sh"]
