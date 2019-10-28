
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

# make user by entrypoint.sh
ENV USER docker
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chmod u+s /usr/sbin/useradd && chmod u+s /usr/sbin/groupadd
COPY entrypoint.sh /entrypoint.sh
WORKDIR /src
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
