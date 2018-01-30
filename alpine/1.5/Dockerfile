FROM elixir:1.5.3-alpine
MAINTAINER nikolauska

# Update env so docker is refreshed fully
ENV REFRESHED_AT=2017-12-25 \
    # Set this so that CTRL+G works properly
    TERM=xterm

# Install NPM
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    mkdir -p /opt/app && \
    chmod -R 777 /opt/app && \
    apk update && \
    apk --no-cache --update add git make g++ wget curl inotify-tools nodejs@edge nodejs-npm@edge && \
    npm install npm -g --no-progress && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

# Add node bin to path, change home directory
ENV PATH=./node_modules/.bin:$PATH \
    HOME=/opt/app

# Install Hex and Rebar again
RUN mix local.hex --force && \
    mix local.rebar --force

# Change workdir to home dir
WORKDIR /opt/app

CMD ["/bin/sh"]
