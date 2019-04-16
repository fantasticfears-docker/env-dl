# NAME:     fantasticfears/dllib-gpu
# VERSION:  2.4.0
FROM fantasticfears/dlbase:3.2

MAINTAINER Erick Guan <fantasticfears@gmail.com>

ARG BAZEL_VERSION=0.21.0

WORKDIR /

# Install Bazel for TF
RUN curl -OL https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
COPY bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256 bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN shasum -a 256 -c bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user

ARG TENSORFLOW_VERSION=1.13.1
# Install TF dependency
RUN pip3 --no-cache-dir install Keras-Applications==1.0.6 --no-deps
RUN pip3 --no-cache-dir install Keras-Preprocessing==1.0.5 --no-deps
RUN pip3 --no-cache-dir install h5py==2.8.0 --no-deps

# Install Tensorflow
COPY build_tf.sh /build_tf.sh
RUN chmod 777 /build_tf.sh
RUN bash /build_tf.sh
RUN pip3 --no-cache-dir install keras

ARG TORCH_VERSION=1.0.1
# Install Torch
RUN pip3 --no-cache-dir install torch torchvision torchbearer

ARG PYFLAME_VERSION=1.6.7
# Install Pyflame
RUN git clone https://github.com/uber/pyflame.git && \
    cd pyflame && \
    git checkout -f tags/v${PYFLAME_VERSION} && \
    ./autogen.sh && \
    ./configure && \
    make && \
    mv src/pyflame /usr/local/bin/pyflame && \
    cd .. && \
    rm -rf pyflame

# Install flamegraph.pl
RUN wget https://raw.githubusercontent.com/brendangregg/FlameGraph/master/flamegraph.pl && \
    chmod 764 flamegraph.pl && \
    mv flamegraph.pl /usr/bin/flamegraph.pl

# Install Spacy

RUN pip3 --no-cache-dir install spacy[cuda92] && \
    python3 -m spacy download en && \
    python3 -m spacy download xx

# Install fastai

RUN pip3 --no-cache-dir install fastai

# Install Nvidia APEX
# RUN cd /root && \
#    git clone https://github.com/NVIDIA/apex.git && \
#    cd apex && \
#    python3 setup.py install --cuda_ext --cpp_ext && \
#    rm -rf /root/apex

# Install Gym
# RUN wget https://www.roboti.us/download/mjpro150_linux.zip && \
#     mkdir -p ~/.mujoco/ && \
#     unzip mjpro150_linux.zip -d /root/.mujoco/mjpro150 && \
#     rm -f mjpro150_linux.zip

# COPY mjkey.txt /root/.mujoco/mjkey.txt
# ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/root/.mujoco/mjpro150/bin
# RUN pip3 --no-cache-dir install 'mujoco-py<1.50.2,>=1.50.1' && \
#     pip3 --no-cache-dir install 'gym[all]'
