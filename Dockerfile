FROM alpine:3.14

# Set up a minimal environment
RUN unset HTTP_PROXY && unset http_proxy && apk --update add bash mandoc man-pages less less-doc

# Add basic dev installers
RUN apk add curl git

# And a basic editor
RUN apk add vim

# Install node
RUN apk add nodejs npm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN source /root/.nvm/nvm.sh && nvm alias $(node --version)

# Install COC
RUN mkdir -p /root/.vim/pack/coc/start
WORKDIR /root/.vim/pack/coc/start
RUN git clone https://github.com/neoclide/coc.nvim.git --depth=1
WORKDIR /root/.vim/pack/coc/start/coc.nvim
RUN npm install esbuild
RUN npm run build
RUN mkdir -p /root/.config/coc/

# Install haskell language server
WORKDIR /usr/local/bin
RUN curl -L https://github.com/haskell/haskell-language-server/releases/download/0.6.0/haskell-language-server-Linux-0.6.0.tar.gz | tar -xz
RUN chmod +x haskell-language-server-*
COPY coc-settings.json /root/.vim/coc-settings.json

# Set up ghc
RUN apk add ghc musl-dev

# Set up dev env
COPY bashrc /root/.bashrc
COPY vimrc /root/.vimrc

# Install cabal and common tools
RUN apk add cabal
RUN cabal update
RUN cabal install implicit-hie

# Work area
RUN mkdir -p /src
WORKDIR /src