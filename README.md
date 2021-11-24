# haskell-docker-dev

Builds a minimal haskell development environment based on apline linux and vim, using COC and haskell-language-server for flychecking and completion.

cabal is installed but not stack.

To use, just build and start an interactive session from the root of your project source.

In your command shell:

```bash
docker build . -t haskell-docker-dev

mkdir my-project
cd my-project

docker run -it --volume ${PWD}:/src haskell-docker-dev:latest bash
```

Or run directly from github

Example: in the container, intialize a cabal project and start editing.

```bash
cabal init -p my-project
vim Main.hs
```

Or extend by adding additional libraries and tools to enable a fast build for your specific project.

```Dockerfile
FROM haskell-docker-dev:latest

RUN cabal update
RUN cabal install c2hs
RUN cabal install microlens
RUN cabal install microlens-th
```

Or extend it even further to create a multi-stage build based on the dev environment.

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

RUN apk add gmp-dev libffi-dev
COPY --from=builder /opt/my-app/dist .

CMD ./build/my-app/my-app
```

Tested with windows powershell and docker desktop.