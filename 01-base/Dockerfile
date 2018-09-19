# NAME:     fantasticfears/dlbase
# VERSION:  0.10.2
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
RUN apt-get install -y software-properties-common \
		zip \
		zsh \
		autojump \
		clang \
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
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	# update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
RUN apt-get upgrade -y

RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN curl https://bootstrap.pypa.io/get-pip.py | python2

# Add SNI support to Python
# Install other useful Python packages using pip
RUN pip2 --no-cache-dir install \
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
		sphinx \
		wheel \
		zmq
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
		sphinx \
		wheel \
		zmq
