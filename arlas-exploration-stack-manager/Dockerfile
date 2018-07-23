FROM ubuntu:18.04

RUN docker_compose_version=1.22.0 && \
   apt-get update && \
# Installing docker
    apt-get -y install apt-transport-https ca-certificates curl \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
   apt-get update && \
   apt-get -y install docker-ce && \
# Installing docker compose
   curl -L "https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
   chmod +x /usr/local/bin/docker-compose && \
# Installing jq (dependency of yq)
   apt -y install jq && \
# Installing python (dependency of pip)
   apt -y install python && \
# Installing pip (required to install a recent version of yq)
   curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
   python get-pip.py && \
   rm -f get-pip.py && \
# Installing yq
   pip install yq

ADD .env ARLAS-Exploration-stack.bash docker-compose.override.yml docker-compose.yml /

ADD  environment /environment/default

ENTRYPOINT ["/bin/bash", "-e", "/ARLAS-Exploration-stack.bash"]
