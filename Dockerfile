FROM bitwalker/alpine-elixir:1.4.5
MAINTAINER nikolauska

# Update env so docker is refreshed fully
ENV REFRESHED_AT=2017-07-19 \
    # Set this so that CTRL+G works properly
    TERM=xterm

# Install NPM
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    mkdir -p /opt/app && \
    chmod -R 777 /opt/app && \
    apk update && \
    apk add --update --no-cache \
        git make g++ wget curl inotify-tools \
        nodejs@edge nodejs-npm@edge python python-dev py-pip && \
    npm install npm -g --no-progress && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

# Add node bin to path, change home directory
ENV PATH=./node_modules/.bin:$PATH \
    HOME=/opt/app

# Install Hex and Rebar again
RUN mix local.hex --force && \
    mix local.rebar --force

RUN pip install -U pip

# Change workdir to home dir
WORKDIR /opt/app

CMD ["/bin/sh"]
