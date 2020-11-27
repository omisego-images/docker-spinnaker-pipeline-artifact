# This is a base image that will provide the basic dependencies for spinnaker pipeline
# Like curl, wget, git, yq, argo-cli

FROM ubuntu:20.04

# install common tools (eg. curl, wget)
RUN apt update && apt -y -q install software-properties-common \
    && apt -y -q install curl wget git

# install yq
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 \
    && add-apt-repository ppa:rmescandon/yq \
    && apt update \
    && apt install yq -y

# install argo cli
ENV ARGO_VERSION=v1.7.10
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGO_VERSION/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

RUN groupadd -r spinnaker && useradd -m -r -g spinnaker spinnaker
USER spinnaker

CMD ["/bin/bash"]
