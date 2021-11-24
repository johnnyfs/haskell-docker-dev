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

Tested with windows powershell and docker desktop.