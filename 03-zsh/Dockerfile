# NAME:     fantasticfears/dl-zsh
# VERSION:  0.4
FROM fantasticfears/dllib:0.4

MAINTAINER Erick Guan <xigu1500@student.miun.se>

RUN echo "Configure oh-my-zsh"
RUN bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/
RUN chmod +x /root/run_jupyter.sh
RUN echo `date +%Y%m%d` > /BUILD_DATE

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/zsh"]
