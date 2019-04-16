# NAME:     fantasticfears/dlbase
# VERSION:  3.1.0
# FROM:     nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04
FROM nvidia/cuda@sha256:ebd522a2c43cb56a5176dff60a993cef0c3570562e1b3aa39f6a3dfb52c30279

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
		clang \
		valgrind \
		autoconf \
		automake \
		autotools-dev \
		libtool \
		libssl-dev \
		zlib1g-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libgdbm-dev \
		libdb5.3-dev \
		libbz2-dev \
		libexpat1-dev \
		liblzma-dev \
		tk-dev \
		libffi-dev \
		make \
		zsh-syntax-highlighting \
		openjdk-8-jdk \
        sudo \
		bc \
		cmake \
		curl \
		g++ \
		gdb \
		libjemalloc1 \
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
		uuid-dev \
		python-pyglet \
		libboost-all-dev \
		libsdl2-dev \
		libosmesa6-dev \
		patchelf \
		ffmpeg \
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

ARG PYTHON_VERSION=3.7.2
RUN cd /tmp && \
	curl -L -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
	tar xf Python-${PYTHON_VERSION}.tar.xz && \
	cd Python-${PYTHON_VERSION} && \
	./configure --prefix=/usr/local --enable-shared --enable-optimizations && \
	make -j12 && \
	make altinstall

RUN cd /tmp && \
        ln -s /usr/local/lib/libpython3.7m.so.1.0 /usr/lib/libpython3.7m.so.1.0 && \
	update-alternatives --install /usr/bin/python python /usr/local/bin/python3.7 1 && \
	update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 1 && \
        python3 --version && \
        ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python3.7/site-packages/lsb_release.py && \
	curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.7 1 && \
    update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3.7 1 && \
	rm -rf /tmp/Python-${PYTHON_VERSION}

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
