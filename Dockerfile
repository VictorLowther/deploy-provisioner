FROM digitalrebar/managed-service
MAINTAINER Victor Lowther <victor@rackn.com>

ENV SERVICE_NAME provisioner

# Set our command
ENTRYPOINT ["/sbin/docker-entrypoint.sh"]

# Get Latest Go
RUN apt-get -y update \
  && apt-get -y install cmake bsdtar createrepo tftpd-hpa \
  && /usr/local/go/bin/go get -u github.com/VictorLowther/sws \
  && cp "$GOPATH/bin/sws" /usr/local/bin \
  && apt-get -y purge make cmake build-essential

COPY tftpd.conf /etc/default/tftpd-hpa
COPY entrypoint.d/*.sh /usr/local/entrypoint.d/
