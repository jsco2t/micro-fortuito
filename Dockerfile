FROM alpine:3.8

# arguments
#ARG KUBECTLURL="https://storage.googleapis.com/kubernetes-release/release/v1.11.3/bin/linux/amd64/kubectl"

# install required dependencies
RUN apk update && apk upgrade && apk add --no-cache \
    bash \
    bind-tools \
    ca-certificates \
    coreutils \
    curl \
    docker \
    git \
    iputils \
    jq \
    less \
    nano \
    python \
    py-pip \
    htop \
    lsof 

# install the aws tools using python
RUN pip install --upgrade --no-cache-dir \
    awscli \
    s3cmd \
    boto3 \
    elasticsearch \
    requests \
    requests-aws4auth

#
# since the following change often - do last
#

# setup environment
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PATH="~/.local/bin:${PATH}" \
    AWS_DEFAULT_REGION="us-east-1"

# remove the need to auth for sudo
RUN echo "go ALL=NOPASSWD: ALL" >> /etc/sudoers


# entrypoint
WORKDIR /root
CMD ["bash"]

# build:
# docker build -t "micro-fortuito:0.01" .
#
# run:
# docker run -it --rm --name micro-fortuito micro-fortuito:0.01:0.01