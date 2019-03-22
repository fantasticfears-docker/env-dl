# NAME:     fantasticfears/data-zsh
# VERSION:  0.1.0
FROM fantasticfears/data-platform:0.1

MAINTAINER Erick Guan <fantasticfears@gmail.com>

RUN echo "Configure oh-my-zsh"
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true && \
    sed -i '1iDISABLE_AUTO_UPDATE=true' ~/.zshrc

RUN mkdir -p /root/.sbt/1.0
COPY global.sbt /root/.sbt/1.0/global.sbt
RUN echo `date +%Y%m%d` > /BUILD_DATE

CMD ["/sbin/my_init"]

WORKDIR "/root"
