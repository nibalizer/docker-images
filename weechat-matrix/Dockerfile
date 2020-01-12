FROM debian:testing-slim

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y -q 
RUN apt-get update -y; apt-get install -q -y \
  build-essential \
  cmake \
  git \
  libolm-dev \
  python3-dev \
  python3-pip \
  weechat-curses \
  weechat-python

# add chat user
RUN useradd -ms /bin/bash chat

# get and build source code
RUN mkdir /var/build
WORKDIR /var/build

RUN git clone https://gitlab.matrix.org/matrix-org/olm.git
WORKDIR /var/build/olm
RUN cmake . -Bbuild
RUN cmake --build build
RUN make install

WORKDIR /var/build
RUN git clone https://github.com/poljar/weechat-matrix.git
WORKDIR /var/build/weechat-matrix
RUN pip3 install -r requirements.txt

# Install and customize
USER chat
RUN make install
WORKDIR /home/chat
RUN mkdir -p .weechat/python/autoload
RUN ln -s /home/chat/.weechat/python/matrix.py /home/chat/.weechat/python/autoload/
