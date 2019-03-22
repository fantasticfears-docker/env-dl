# NAME:     fantasticfears/data-zsh
# VERSION:  0.2.0
FROM fantasticfears/data-platform:0.2

MAINTAINER Erick Guan <fantasticfears@gmail.com>

RUN echo "Configure oh-my-zsh"
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true && \
    sed -i '1iDISABLE_AUTO_UPDATE=true' ~/.zshrc

RUN mkdir -p /root/.sbt/1.0
COPY global.sbt /root/.sbt/1.0/global.sbt
RUN echo `date +%Y%m%d` > /BUILD_DATE

# CLI tools
COPY alias.sh /root/
COPY git_config.txt /root/
RUN mv /root/alias.sh /root/.alias && \
    echo "source ~/.alias" >> ~/.zshrc && \
    cat /root/git_config.txt >> .gitconfig && \
    rm -f /root/git_config.txt && \
    tldr cd
# Triger update on tldr

CMD ["/sbin/my_init"]

WORKDIR "/root"
