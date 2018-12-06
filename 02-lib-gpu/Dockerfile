# NAME:     fantasticfears/dllib-gpu
# VERSION:  0.6.0
FROM fantasticfears/dlbase:1.0

MAINTAINER Erick Guan <fantasticfears@gmail.com>

ARG BAZEL_VERSION=0.17.1
ARG TENSORFLOW_VERSION=1.12.0
ARG TORCH_VERSION=0.4.1

WORKDIR /

# Install Bazel for TF
RUN curl -OL https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
COPY bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256 bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN shasum -a 256 -c bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user

# Install TF dependency
RUN pip2 --no-cache-dir install Keras-Applications==1.0.6 --no-deps
RUN pip3 --no-cache-dir install Keras-Applications==1.0.6 --no-deps
RUN pip2 --no-cache-dir install Keras-Preprocessing==1.0.5 --no-deps
RUN pip3 --no-cache-dir install Keras-Preprocessing==1.0.5 --no-deps
RUN pip2 --no-cache-dir install h5py==2.8.0 --no-deps
RUN pip3 --no-cache-dir install h5py==2.8.0 --no-deps

# Install Tensorflow
COPY build_tf.sh /build_tf.sh
RUN chmod 777 /build_tf.sh
RUN bash /build_tf.sh

RUN rm -rf /bazel* && rm -rf /build_tf.sh && rm -rf ~/bin

# Install Torch
RUN pip3 --no-cache-dir install http://download.pytorch.org/whl/cu92/torch-${TORCH_VERSION}-cp36-cp36m-linux_x86_64.whl
RUN pip3 --no-cache-dir install torchvision
RUN pip2 --no-cache-dir install http://download.pytorch.org/whl/cu92/torch-${TORCH_VERSION}-cp27-cp27mu-linux_x86_64.whl
RUN pip2 --no-cache-dir install torchvision

# Install Keras

RUN pip3 --no-cache-dir install keras

# Install Gym
RUN wget https://www.roboti.us/download/mjpro150_linux.zip && \
    mkdir -p ~/.mujoco/ && \
    unzip mjpro150_linux.zip -d /root/.mujoco/mjpro150 && \
    rm -f mjpro150_linux.zip

COPY mjkey.txt /root/.mujoco/mjkey.txt
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/root/.mujoco/mjpro150/bin
RUN pip3 --no-cache-dir install 'mujoco-py<1.50.2,>=1.50.1' && \
    pip3 --no-cache-dir install 'gym[all]'
