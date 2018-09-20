#!/usr/bin/env bash
set -e
gcc --version

# Compile TensorFlow

# Here you can change the TensorFlow version you want to build.
# You can also tweak the optimizations and various parameters for the build compilation.
# See https://www.tensorflow.org/install/install_sources for more details.

cd /
rm -fr tensorflow/
git clone --depth 1 --branch v$TENSORFLOW_VERSION "https://github.com/tensorflow/tensorflow.git"

export TF_ROOT=/tensorflow
cd $TF_ROOT

# Python path options
export PYTHON_BIN_PATH=$(which python3)
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"
export PYTHONPATH=${TF_ROOT}/lib
export PYTHON_ARG=${TF_ROOT}/lib

# Compilation parameters
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export CUDNN_INSTALL_PATH=/usr/local/cuda
export NCCL_INSTALL_PATH=/usr
ln -s /usr/lib/x86_64-linux-gnu/libnccl.so /usr/lib/libnccl.so.2
export TF_CUDA_VERSION="$CUDA_VERSION"
export TF_CUDNN_VERSION="$CUDNN_VERSION"
export TF_NCCL_VERSION=2
export TF_NEED_CUDA=1
export TF_NEED_GCP=1
export TF_NEED_TENSORRT=0
export TF_CUDA_COMPUTE_CAPABILITIES=6.1
export TF_NEED_HDFS=1
export TF_NEED_OPENCL=0
export TF_NEED_JEMALLOC=1  # Need to be disabled on CentOS 6.6
export TF_ENABLE_XLA=0
export TF_NEED_VERBS=0
export TF_CUDA_CLANG=0
export TF_DOWNLOAD_CLANG=0
export TF_NEED_MKL=0
export TF_DOWNLOAD_MKL=0
export TF_NEED_MPI=0
export TF_NEED_S3=1
export TF_NEED_KAFKA=1
export TF_NEED_GDR=0
export TF_NEED_OPENCL_SYCL=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_NEED_AWS=0

export PATH="/usr/bin:${HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="/usr/local/lib:$CUDA_TOOLKIT_PATH/lib64:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"
echo "/usr/local/cuda/targets/x86_64-linux/lib/stubs" > /etc/ld.so.conf.d/cuda-92-stubs.conf
ldconfig
echo $LD_LIBRARY_PATH

# Compiler options
export GCC_HOST_COMPILER_PATH=$(which gcc)
export CC_OPT_FLAGS="-march=native"

# Compilation
./configure

rm -rf /usr/local/cuda/lib64/stubs/libcuda.so.1
ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
bazel build --config=opt \
            --config=cuda \
            --verbose_failures \
            --action_env="LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" \
            //tensorflow/tools/pip_package:build_pip_package

PROJECT_NAME="tensorflow_gpu_cuda_${TF_CUDA_VERSION}_cudnn_${TF_CUDNN_VERSION}"
bazel-bin/tensorflow/tools/pip_package/build_pip_package /wheels --project_name $PROJECT_NAME

# Fix wheel folder permissions
chmod -R 777 /wheels/
pip3 --no-cache-dir install --upgrade /wheels/*.whl
rm -rf /wheels

# Complication for python 2
export PYTHON_BIN_PATH=$(which python2)
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"

bazel clean

./configure

bazel build --config=opt \
            --config=cuda \
            --action_env="LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" \
            //tensorflow/tools/pip_package:build_pip_package

bazel-bin/tensorflow/tools/pip_package/build_pip_package /wheels --project_name $PROJECT_NAME
rm -rf /usr/local/cuda/lib64/stubs/libcuda.so.1
rm -rf /etc/ld.so.conf.d/cuda-92-stubs.conf

# # Fix wheel folder permissions
chmod -R 777 /wheels/
pip2 --no-cache-dir install --upgrade /wheels/*.whl
rm -rf /tensorflow
rm -rf /wheels
