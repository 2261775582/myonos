FROM onosproject/onos:2.7-latest

LABEL org.label-schema.name="ONOS" \
      org.label-schema.description="SDN Controller" \
      org.label-schema.usage="http://wiki.onosproject.org" \
      org.label-schema.url="http://onosproject.org" \
      org.label-scheme.vendor="Open Networking Foundation" \
      org.label-schema.schema-version="1.0" \
      maintainer="onos-dev@onosproject.org"

RUN apt-get update && apt-get install -y curl git maven && \
	rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME (by default not exported by zulu images)
ARG JAVA_PATH
ENV JAVA_HOME ${JAVA_PATH}

RUN mkdir /root/onos_dev/
WORKDIR /root/onos_dev
RUN git clone -b 2.7.0 https://github.com/opennetworkinglab/onos.git

# Install ONOS in /root/onos
RUN mkdir /root/onos/
WORKDIR /root/onos

# Ports
# 6653 - OpenFlow
# 6640 - OVSDB
# 8181 - GUI
# 8101 - ONOS CLI
# 9876 - ONOS intra-cluster communication
EXPOSE 6653 6640 8181 8101 9876

# Run ONOS
ENTRYPOINT ["./bin/onos-service"]
CMD ["server"]
