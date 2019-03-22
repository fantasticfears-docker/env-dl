# NAME:     fantasticfears/data-base
# VERSION:  0.1.0
# FROM:     phusion/baseimage:0.11
FROM phusion/baseimage:0.11

MAINTAINER Erick Guan <fantasticfears@gmail.com>

RUN apt-get update
RUN apt-get install -y curl vim build-essential git wget locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN echo "Europe/Stockholm" > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install some dependencies
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update && \
	apt-get install -y software-properties-common \
		zip \
		zsh \
		autojump \
		make \
		zsh-syntax-highlighting \
		openjdk-8-jdk \
        sudo \
		curl \
		unzip \
		default-jdk \
		python \
		python2.7-dev \
		xvfb \
		htop \
		ncdu \
		sbt \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	# update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3

# Install new CLI tools
ARG BAT_VERSION=0.9.0
ARG PRETTY_PING_VERSION=1.0.1
ARG FZF_VERSION=0.17.5
ARG DIFF_SO_FANCY_VERSION=1.2.0
ARG FD_VERSION=7.2.0
ARG NODE_VERSION=11

RUN mkdir -p /root/tmp && \
	cd /root/tmp && \
	curl -O -L https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb && \
	dpkg -i bat_${BAT_VERSION}_amd64.deb && \
	curl -O -L https://github.com/denilsonsa/prettyping/archive/v${PRETTY_PING_VERSION}.tar.gz && \
   	tar xzf v${PRETTY_PING_VERSION}.tar.gz && \
	cd prettyping-${PRETTY_PING_VERSION} && \
	chmod +x prettyping && \
	mv prettyping /usr/bin/prettyping && \
	cd .. && \
	curl -O -L https://github.com/junegunn/fzf/archive/${FZF_VERSION}.tar.gz && \
	tar xzf ${FZF_VERSION}.tar.gz && \
        mv fzf-${FZF_VERSION} /usr/lib/fzf && \
	/usr/lib/fzf/install && \
	curl -O -L https://github.com/so-fancy/diff-so-fancy/archive/v${DIFF_SO_FANCY_VERSION}.tar.gz  && \
	tar xzf v${DIFF_SO_FANCY_VERSION}.tar.gz && \
	cp diff-so-fancy-${DIFF_SO_FANCY_VERSION}/diff-so-fancy /usr/bin && \
	curl -O -L https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_${FD_VERSION}_amd64.deb && \
	dpkg -i fd_${FD_VERSION}_amd64.deb && \
	curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash - && \
	apt-get update && \
	apt-get install -y nodejs && \
	sudo npm install --unsafe-perm -g tldr jq && \
	rm -rf /root/tmp && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

# CLI tools
COPY alias.sh /root/
COPY git_config.txt /root/
RUN mv /root/alias.sh /root/.alias && \
    echo "source ~/.alias" >> ~/.zshrc && \
    cat /root/git_config.txt >> .gitconfig && \
    rm -f /root/git_config.txt && \
    tldr cd
# Triger update on tldr
