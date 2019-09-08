FROM ubuntu:18.04 AS base-img

# install dependencies
RUN apt update
RUN apt install python-pip -y
RUN apt install python3-pip -y
RUN apt install nodejs -y
RUN apt install npm -y
RUN pip2 install neovim
RUN pip install neovim
RUN npm install -g neovim
RUN apt install curl -y
RUN apt install wget -y
RUN apt install jq -y
RUN apt install git -y
RUN npm install -g eslint
RUN npm install -g yarn

# download nvim.appimage
RUN curl -fLo /usr/bin/nvim-dir/nvim --create-dirs \
    https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage \
    && chmod +x /usr/bin/nvim-dir/nvim

# go to the dir where it was downloaded
WORKDIR /usr/bin/nvim-dir
# extract the app image
RUN ./nvim --appimage-extract

# create the shell script to forward the execution to the nvim
RUN printf '#!/bin/bash\n/usr/bin/nvim-dir/squashfs-root/AppRun "$@"' > /usr/bin/nvim \
    && chmod +x /usr/bin/nvim

# create the default config directory
RUN mkdir -p /root/.config/nvim

# download and install vim plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR /root

# ARG CACHE_DATE=2016-01-01
RUN git clone https://github.com/adrianoviana87/vim-pure.git

RUN echo 'execute "source " . fnamemodify(expand("$HOME") . "/vim-pure/settings.vim", ":p")' > /root/.config/nvim/init.vim

RUN nvim +PlugInstall +qall

RUN nvim -c 'CocInstall -sync coc-lists coc-json coc-html coc-css coc-yaml coc-tsserver coc-eslint coc-docker coc-omnisharp|q'

WORKDIR /root

COPY ./install-rg.sh .

RUN chmod +x ./install-rg.sh

RUN ./install-rg.sh

RUN mkdir -p /var/nvim-edit

WORKDIR /var/nvim-edit

CMD ["nvim", "/var/nvim-edit"]
