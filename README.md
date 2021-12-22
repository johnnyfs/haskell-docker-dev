# haskell-docker-dev

Builds a minimal haskell development environment based on apline linux and vim, using COC and haskell-language-server for flychecking and completion.

cabal is installed but not stack.

## Basic command line setup

To use, just build and start an interactive session from the root of your project source.

In your command shell:

```bash
docker build . -t haskell-docker-dev

mkdir my-project
cd my-project

docker run -it --volume ${PWD}:/src haskell-docker-dev:latest bash
```

Example: in the container, intialize a cabal project and start editing.

```bash
cabal init -p my-project
vim Main.hs
```

## Custom per-project derivatives

Extend by creating a dependent docker file that adds additional libraries and tools to enable a fast build for your specific project.

```Dockerfile
FROM haskell-docker-dev:latest

RUN cabal update
RUN cabal install c2hs
RUN cabal install microlens
RUN cabal install microlens-th
```

## Multi-stage dev/build/prod

Extend even further to create a multi-stage build based on the dev environment. (The runtime containers are usually only ~2MB.)

```Dockerfile
FROM haskell-docker-dev:latest AS dev

RUN cabal update
RUN cabal install bytestring data-hash microlens microlens-th mtl parsec

FROM dev AS builder

WORKDIR /opt/my-app
COPY my-app.cabal .
RUN cabal v1-install --only-dependencies -j
ADD . .
RUN cabal v1-install

FROM alpine:3.14

# Install minimal runtime support for cabal apps
RUN apk add gmp-dev libffi-dev
COPY --from=builder /opt/my-app/dist .

CMD ./build/my-app/my-app
```

## Graphical environment with gvim

You'll need an xserver running in your host ui.

### On windows 11:

Install [Xming](http://www.straightrunning.com/XmingNotes/) works for windows.

Run the provided app Xlaunch with "multiple windows", "start no client", check "Disable access control".

In powershell, find your machines network IP by running:

```
Get-NetIPAddress -AddressFamily IPv4
```

Then pass the display address to the docker container as an environment variable:

```
Set-Variable -name DISPLAY -value $MY_IPADDRESS:0.0
docker.exe run -it --volume ${PWD}:/src -e DISPLAY=$DISPLAY haskell-docker-dev bash
```

Inside the container, run `gvim` from the command prompt. It should open in your windows environment.

(NOTE: the provided `.vimrc` includes the following settings to disable the menu and toolbar:

```
set guioptions-=m
set guioptions-=T
```

Comment them out if you prefer more widgets and less window space.)

Tested with windows powershell and docker desktop.