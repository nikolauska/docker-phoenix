FROM ubuntu:latest

MAINTAINER Nikolauska <nikolauska1@gmail.com>

ENV ELIXIR_VERSION 1.4.5

# update and install software
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl wget git make sudo tar bzip2 libfontconfig unzip \
    build-essential && \
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    rm erlang-solutions_1.0_all.deb && \
    touch /etc/init.d/couchdb && \
    apt-get install -y erlang erlang-dev erlang-dialyzer erlang-parsetools && \
    apt-get clean && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/

# Install nodejs LTS
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs

# Add local node module binaries to PATH
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install phantomjs and node sass
RUN sudo npm install -g node-sass phantomjs-prebuilt
