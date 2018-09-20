# NAME:     fantasticfears/dllib-gpu
# VERSION:  0.5.0
FROM fantasticfears/dlbase:0.10.3

MAINTAINER Erick Guan <fantasticfears@gmail.com>

ARG BAZEL_VERSION=0.17.1
ARG TENSORFLOW_VERSION=1.10.1
ARG TORCH_VERSION=0.4.1

WORKDIR /

# Install Bazel for TF
RUN curl -OL https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
COPY bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256 bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN shasum -a 256 -c bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh.sha256
RUN chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user

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
