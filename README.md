# :koala: nokxpkgs :koala:

[![CI-linux](https://github.com/nokx5/nokxpkgs/workflows/CI-linux/badge.svg)](https://github.com/nokx5/nokxpkgs/actions/workflows/ci-linux.yml) [![CI-linux](https://github.com/nokx5/nokxpkgs/workflows/CI-darwin/badge.svg)](https://github.com/nokx5/nokxpkgs/actions/workflows/ci-darwin.yml) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nokx5/nokxpkgs/blob/master/LICENSE) <!-- [![doc](https://github.com/nokx5/nokxpkgs/workflows/doc-api/badge.svg)](https://nokx5.github.io/nokxpkgs) -->

Welcome to the official **nokxpkgs** channel of [nokx](https://github.com/nokx5/)!

This nokxpkgs channel contains all [*(overlayed)*](https://github.com/nokx5/nokxpkgs/blob/main/nixpkgs-nokx/default.nix) nokx softwares pinned with an official [**_stable_ nixpkgs**](https://github.com/nokx5/nokxpkgs/blob/main/default.nix#L5-L12) to help creating fully reproducible software expressions.

## How to use a nokx software

Here we explain how to use a nokx software pinned according to a specific release ([`735a949`](https://github.com/nokx5/nokxpkgs/commit/735a9490b0dccb6aab3a30fa4195c38790857b74)). We illustrate this with the **golden-cpp** software.

```bash
nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/735a9490b0dccb6aab3a30fa4195c38790857b74.tar.gz --pure -p golden-cpp

$ cli_golden_cpp
Welcome to nokx cpp golden project!
```
Nix is an amazing tool ! Give it a try! :ghost:


## Available nokx software

***

**All nokx**

-   [x] all-nokx - *aggregate all nokx projects*
-   [ ] all-nokx-dev - *aggregate all nokx dependencies for builds of nokx projects*
-   [x] all-nokx-dev-full - *aggregate all nokx dependencies for builds of nokx projects with supercharged environments :artificial_satellite: :artificial_satellite: :artificial_satellite:

***

**C/C++ projects**

- [x] [golden-cpp](https://github.com/nokx5/golden-cpp)
***
**C++/Python projects**

- [x] [python3Packages.golden-pybind11](https://github.com/nokx5/golden-pybind11)
***
**Go projects**

- [x]  [golden-go](https://github.com/nokx5/golden-go)

***
**Python projects**

- [x] [golden-python_cli](https://github.com/nokx5/golden-python)
- [x] [python3Packages.golden-python](https://github.com/nokx5/golden-python)
- [x] [python3Packages.golden-python_cli](https://github.com/nokx5/golden-python)
- [x] [python3Packages.speedo](https://github.com/nokx5/speedo)
- [x] [python3Packages.speedo_client](https://github.com/nokx5/speedo)
- [x] [speedo](https://github.com/nokx5/speedo)
***
**Rust projects**

- [x] [golden-rust](https://github.com/nokx5/golden-rust)

***
**Scripts & Automation**

-   [ ] barthelemy
-   [ ] nixOS configurations

***



## How to develop a nokx software

> In order to start developing a nokx software, please refer to the specific software documentation if available.

#### `nix-shell` - in a nutshell

All [nokx](https://github.com/nokx5/) softwares started with a `nix-shell` command using a `shell.nix` script. This file uses most probably the official **_stable/unstable_ nixpkgs** channel (see the channel section [below](#add-nokxpkgs-to-your-nix-channel)). It will create you an environment to develop with.

#### `nix-build` - in a nutshell

The [nokxpkgs](#) channel uses all overlays of all nokx project and give access to it from the `default.nix` script.

```bash
# build all nokx projects for Linux and MacOS
nix-build -I nokxpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz --expr '(import <nokxpkgs> {}).all-nokx' --no-out-link
```

#### `repl` - in a nutshell

The repl could be helpfull to find the available softwares.

```bash
git clone https://github.com/nokx5/nokxpkgs.git
cd nokxpkgs
nix repl -I nixpkgs=$PWD
> pkgs = import <nixpkgs> {}
```

Note that you do not need to clone the project to use the nix repl with nokx softwares. Fantastic! :smile:

### Add nokxpkgs to your nix channel

*Please keep in mind that flakes were invented to simplify considerably the update of nix channels.*

To avoid repeating the urls, use nix channels.

```bash
nix-channel --list
```

You can easily add **nokxpkgs** to your list.
```bash
nix-channel --add https://github.com/nokx5/nokxpkgs/archive/main.tar.gz nokxpkgs
nix-channel --update
```

You can always remove the channel
```
nix-channel --remove nokxpkgs
nix-collect-garbage -d
```

Don't forget to update and clean sometimes your nix store. :wink:

## Comments

### Usefull nix documentation

Follow the documentation in the right order.

- [Nix pills](https://nixos.org/guides/nix-pills/index.html), just read it :pill:
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/), usefull for each programming language :mushroom:
- [Hook and phases](https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases), usefull to debug packages :art:
- [Overlays](https://www.youtube.com/watch?v=W85mF1zWA2o), very nice nix design pattern :lipstick:
- [Flakes](https://www.tweag.io/blog/2020-05-25-flakes/), hard but necessary :snowflake:

### Usefull nix commands

* Format nix code

```bash
nixfmt $(find -name "*.nix")
```

* Update repo (absent feature)

```bash
nix-shell maintainers/scripts/update.nix --argstr package PACKAGE --argstr revision REVISION --show-trace
```

add env to cache
```bash
nix-build . -A all-nokx --out-link dev-link
# experimental features
nix develop .#hydraJobs.release.x86_64-linux --profile dev-profile
nix build .#hydraJobs.release.x86_64-linux --out-link dev-2-link
# # full-dev
nix-build . -A all-nokx-dev-full --out-link dev-full-link
# experimental features
nix develop .#hydraJobs.build-all-dev-full.x86_64-linux --profile dev-full-profile
nix build .#hydraJobs.build-all-dev-full.x86_64-linux --out-link dev-full-2-link
```


