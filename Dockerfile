
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

ENV USER tf-docker

ARG UID=9001
ARG GID=9001
RUN useradd -u $UID -o -m ${USER}
RUN groupmod -g $GID -o ${USER}

USER ${USER}
WORKDIR /src

