FROM miun:dlbase

RUN useradd erickg -s /bin/zsh -m -U

RUN echo "Configure oh-my-zsh"
RUN su erickg
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
