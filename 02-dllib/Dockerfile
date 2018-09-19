# NAME:     fantasticfears/dllib
# VERSION:  0.4
FROM fantasticfears/dlbase:0.9

MAINTAINER Erick Guan <xigu1500@student.miun.se>

ARG TENSORFLOW_VERSION=1.8.0
ARG TORCH_VERSION=0.4.0

# Install Tensorflow
RUN pip2 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl
RUN pip3 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-${TENSORFLOW_VERSION}-cp36-cp36m-linux_x86_64.whl

# Install Torch
RUN pip3 --no-cache-dir install http://download.pytorch.org/whl/cu91/torch-${TORCH_VERSION}-cp36-cp36m-linux_x86_64.whl
RUN pip3 --no-cache-dir install torchvision
RUN pip2 --no-cache-dir install http://download.pytorch.org/whl/cu91/torch-${TORCH_VERSION}-cp27-cp27mu-linux_x86_64.whl
RUN pip2 --no-cache-dir install torchvision
