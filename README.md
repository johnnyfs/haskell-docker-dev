# haskell-docker-dev
## A lightweight(ish) containerized instant haskell (cabal) dev environment using vim

To use, just build and start an interactive session from the root of your project source.

In your command shell:

```sh
docker build . -t haskell-docker-dev

mkdir my-project
cd my-project
docker run -it --volume ${PWD}:/src haskell-docker-dev:latest bash
```

In the container:

```bash
cabal init -p my-project
vim Main.hs
```

Or extend by adding additional libraries and tools to create a fast build environment for your local project.

```Dockerfile
FROM haskell-docker-dev:latest

RUN cabal update
RUN cabal install c2hs
RUN cabal install microlens
RUN cabal install microlens-th
```