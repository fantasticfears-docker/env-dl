# NAME:     fantasticfears/dlzsh
# VERSION:  0.8.1
FROM fantasticfears/dllib-gpu:0.8

MAINTAINER Erick Guan <fantasticfears@gmail.com>

ENV CUDA_VISIBLE_DEVICES=0,1

RUN echo "Configure oh-my-zsh"
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/
RUN chmod +x /root/run_jupyter.sh

# CLI tools
COPY alias.sh /root/
COPY git_config.txt /root/
RUN mv /root/alias.sh /root/.alias && \ 
    echo "source ~/.alias" >> ~/.zshrc && \
    cat /root/git_config.txt >> .gitconfig && \
    rm -f /root/git_config.txt && \
    tldr cd
# Triger update on tldr

RUN echo `date +%Y%m%d` > /BUILD_DATE

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/sbin/init"]
