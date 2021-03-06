FROM centos:7

MAINTAINER Nikolauska <nikolauska1@gmail.com>

# Environment variables
ENV ELIXIR=1.6.6 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN yum update -y && \
    # Setup locales
    localedef -i en_US -f UTF-8 en_US.UTF-8 && locale && \
    # Setup build tools
    yum install -y curl wget git make gcc gcc-c++ sudo tar bzip2 unzip wxGTK && \
    # Add EPEL Repo
    wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -ivh epel-release-latest-7.noarch.rpm && \
    rm epel-release-latest-7.noarch.rpm && \
    # Install erlang
    wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    rpm -ivh erlang-solutions-1.0-1.noarch.rpm && \
    rm erlang-solutions-1.0-1.noarch.rpm && \
    yum install -y erlang && \
    # Install elixir
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR}/ && \
    rm Precompiled.zip && \
    # Install nodejs LTS
    curl -sL https://rpm.nodesource.com/setup_8.x | sudo -E bash - && \
    sudo yum install -y nodejs

ENV PATH=$PATH:/opt/elixir-${ELIXIR}/bin

# Setup hex, rebar and phx
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

CMD ["/bin/sh"]
