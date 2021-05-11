# :koala: nokxpkgs :koala:

Welcome to the official **nokxpkgs** channel of [nokx](https://github.com/nokx5/)!

This nokxpkgs channel contains all [*(overlayed)*](https://github.com/nokx5/nokxpkgs/blob/main/nixpkgs-nokx/default.nix) nokx softwares pinned with an official [**_stable_ nixpkgs**](https://github.com/nokx5/nokxpkgs/blob/main/default.nix#L5-L12) to help creating fully reproducible software expressions.

## How to use a nokx software

Here we explain how to use a nokx software pinned according to a specific release ([`0c42647`](https://github.com/nokx5/nokxpkgs/commit/0c426477b0366270c6dea904f427ed8b15e39a4f)). We illustrate this with the **golden_cpp** software.

```bash
nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/0c426477b0366270c6dea904f427ed8b15e39a4f.tar.gz --pure -p golden_cpp

$ cli_golden_cpp
Welcome to nokx cpp golden project!
```
Nix is an amazing tool ! Give it a try! :ghost:

## How to develop a nokx software

> In order to start developing a nokx software, please refer to the
  specific software documentation if available.

All [nokx](https://github.com/nokx5/) softwares started with a nix shell script, which by default moved to `default-shell.nix`. This file is in general using the official **_stable/unstable_ nixpkgs** channel. The `default.nix` instead appears when the project joined the **nokxpkgs** channel. Thus two solutions exist to start developing :


1. Use the `default.nix` :

    Enter a shell, build a pkgs, use your local changes, simplify your workflow [after adding the **nokxpkgs** channel](#add-nokxpkgs-to-your-nix-channel)
    ```bash
    # you can avoid this export by adding nokxpkgs to your channels
    export NIX_PATH=nokxpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz

    # option 1: develop the local software
    nix-shell -A dev
    $ exit

    # option 2: build the local software
    nix-build -A dev
    unlink result*

    # option 3: use your local changes
    nix-shell -I nixpkgs=$PWD -p dev
    $ exit
    ```
    In general, you will find other available derivation within the `default.nix`, e.g. `-A golden_cpp` (no dev tools).


2. Use the `default-shell.nix` :

    Project development always start with a nix shell file, here named `default-shell.nix`. This file creates a shell with the nixpkgs channel (**deprecated**).
    ```bash
    nix-shell default-shell.nix
    ```
    This command could fail due to the **_unstable_** evolution of the **nixpkgs** channel. However, it could work within the pinned nokxpkgs  workflow. You can enter a *similar* environment than the one created by the `default.nix`.
    ```bash
    nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz default-shell.nix
    ```

3. You can use the overlay `nixpkgs-nokx` directly in your nix script but let's not confuse anyone at this point.

4. Us~~e the `flakes.nix` directly.~~ Let's be honest, I'm still working on this experimental feature. :blush:

### Add nokxpkgs to your nix channel

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

## Available nokx software

***
**C/C++ projects**

- [x] [golden_cpp](https://github.com/nokx5/golden_cpp)
***
**C++/Python projects**

- [x] [python3Packages.golden_binding](https://github.com/nokx5/golden_binding)
***
**Go projects**

***
**Python projects**
- [x] [golden_python_cli](https://github.com/nokx5/golden_python)
- [x] [python3Packages.golden_python](https://github.com/nokx5/golden_python)
- [x] [python3Packages.golden_python_cli](https://github.com/nokx5/golden_python)
- [x] [python3Packages.speedo](https://github.com/nokx5/speedo)
- [x] [python3Packages.speedo_client](https://github.com/nokx5/speedo)
- [x] [speedo](https://github.com/nokx5/speedo)
***
**Rust projects**

- [x] [golden_rust](https://github.com/nokx5/golden_rust)
- [ ] [moonraker](https://github.com/nokx5/moonraker)
***
**Scripts & Automation**

---

**Snippets (Nix)**

****

- [x] all-nokx
- [ ] nokx-tools

***

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
