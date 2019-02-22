# NAME:     fantasticfears/dlzsh
# VERSION:  2.1.0
FROM fantasticfears/dllib-gpu:2.1

MAINTAINER Erick Guan <fantasticfears@gmail.com>

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
        mv fzf-${FZF_VERSION} /usr/lib/fzf && \
	/usr/lib/fzf/install && \
	curl -O -L https://github.com/so-fancy/diff-so-fancy/archive/v${DIFF_SO_FANCY_VERSION}.tar.gz  && \
	tar xzf v${DIFF_SO_FANCY_VERSION}.tar.gz && \
	cp diff-so-fancy-${DIFF_SO_FANCY_VERSION}/diff-so-fancy /usr/bin && \
	curl -O -L https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_${FD_VERSION}_amd64.deb && \
	dpkg -i fd_${FD_VERSION}_amd64.deb && \
	curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash - && \
	apt-get update && \
	apt-get install -y nodejs && \
	sudo npm install --unsafe-perm -g tldr jq && \
	rm -rf /root/tmp && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

ENV CUDA_VISIBLE_DEVICES=0,1

RUN echo "Configure oh-my-zsh"
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true && \
    sed -i '1iDISABLE_AUTO_UPDATE=true' ~/.zshrc

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
