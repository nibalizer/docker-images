FROM debian:testing-slim

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y; apt-get install -q -y \
  build-essential \
  cmake \
  git \
  libolm-dev \
  python3-dev \
  python3-pip \
  weechat-curses \
  weechat-python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -fr /root/.cache

# add chat user
# get and build source code
RUN useradd -ms /bin/bash chat && mkdir /var/build
WORKDIR /var/build

RUN git clone https://gitlab.matrix.org/matrix-org/olm.git
WORKDIR /var/build/olm
RUN cmake . -Bbuild && cmake --build build && make install

WORKDIR /var/build
RUN git clone https://github.com/poljar/weechat-matrix.git
WORKDIR /var/build/weechat-matrix
RUN pip3 install -r requirements.txt


# Install and customize
USER chat
RUN make install

# Clean Up
USER root
RUN apt-get -y -q purge build-essential cmake && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -fr /root/.cache

USER chat
WORKDIR /home/chat
RUN mkdir -p .weechat/python/autoload && ln -s /home/chat/.weechat/python/matrix.py /home/chat/.weechat/python/autoload/
