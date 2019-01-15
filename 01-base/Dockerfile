# NAME:     fantasticfears/dlbase
# VERSION:  1.2.0
FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04

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
RUN apt-get update && \
	apt-get install -y software-properties-common \
		zip \
		zsh \
		autojump \
		clang \
		autoconf \
		automake \
		autotools-dev \
		python3-dev \
		libtool \
		make \
		zsh-syntax-highlighting \
		openjdk-8-jdk \
        sudo \
		bc \
		cmake \
		curl \
		g++ \
		libjemalloc1 \
		python3-dev \
		zlib1g-dev \
		libffi-dev \
		libfreetype6-dev \
		pkg-config \
		libjpeg-dev \
		libopenblas-dev \
		libwebp-dev \
		libblas-dev \
		libjpeg-dev \
		libwebp-dev \
		libpng-dev \
		unzip \
		default-jdk \
		python \
		python2.7-dev \
		swig \
		python-pyglet \
		python3-opengl \
		libboost-all-dev \
		libsdl2-dev \
		libosmesa6-dev \
		patchelf \
		ffmpeg \
		xvfb \
		htop \
		ncdu \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	# update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3

RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# Add SNI support to Python
# Install other useful Python packages using pip
RUN pip3 --no-cache-dir install \
		numpy \
		scipy \
		nose \
		h5py \
		scikit-image \
		matplotlib \
		pandas \
		sklearn \
		sympy \
		pipenv \
		pyopenssl \
		ndg-httpsclient \
		pyasn1 \
		Cython \
		jupyterlab \
		Pillow \
		pygments \
		six \
		mock \
		sphinx \
		wheel \
		zmq

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
	./fzf-${FZF_VERSION}/install && \
	curl -O -L https://github.com/so-fancy/diff-so-fancy/archive/v${DIFF_SO_FANCY_VERSION}.tar.gz  && \
	tar xzf v${DIFF_SO_FANCY_VERSION}.tar.gz && \
	cp diff-so-fancy-${DIFF_SO_FANCY_VERSION}/diff-so-fancy /usr/bin && \
	curl -O -L https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_${FD_VERSION}_amd64.deb && \
	dpkg -i fd_${FD_VERSION}_amd64.deb && \
	snap install node --classic --channel=${NODE_VERSION} && \
	npm install -g tldr jq && \
	rm -rf /root/tmp
