FROM alpine:edge

# enable testing repository
RUN echo 'http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk add olm-dev python3 git weechat weechat-python build-base python3-dev libffi-dev openssl-dev

# add chat user
# Thanks Stack Overflow!
RUN addgroup -S chat && adduser -S chat -G chat

# get and build source code
WORKDIR /var/build
RUN git clone https://github.com/poljar/weechat-matrix.git
WORKDIR /var/build/weechat-matrix
RUN pip3 install -r requirements.txt

# Install and setup autoloading
USER chat
RUN make install
WORKDIR /home/chat
RUN mkdir -p .weechat/python/autoload && ln -s /home/chat/.weechat/python/matrix.py /home/chat/.weechat/python/autoload/
