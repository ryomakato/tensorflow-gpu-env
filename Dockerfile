
ARG TENSORFLOW_VERSION=latest-gpu-py3

FROM tensorflow/tensorflow:${TENSORFLOW_VERSION}

ENV DEBCONF_NOWARNINGS yes
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ./requirements.txt /tmp/
RUN pip install -U pip setuptools && pip install -r /tmp/requirements.txt

RUN ldconfig && apt-get clean && apt-get autoremove

# make user
ENV USER docker
RUN useradd -m ${USER}
RUN echo "${USER}:${USER}" | chpasswd
RUN adduser ${USER} sudo	
RUN echo "${USER} ALL=NOPASSWD:ALL" >> /etc/sudoers
USER ${USER}

WORKDIR /src

