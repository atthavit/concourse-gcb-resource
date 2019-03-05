FROM google/cloud-sdk:alpine

RUN apk add -U --no-cache \
        bash \
        jq

RUN mkdir -p /opt/resource
COPY assets/* /opt/resource/
RUN chmod +x /opt/resource/*

ENTRYPOINT ["/bin/bash"]
