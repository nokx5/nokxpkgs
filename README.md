# :koala: nokxpkgs :koala:

Welcome to the official **nokxpkgs** channel of [nokx](https://github.com/nokx5/)!

This nokxpkgs channel contains all *(overlayed)* nokx softwares pinned with an official **_stable_ nixpkgs** to help creating fully reproducible software expressions.

## How to use a nokx software

Here we explain how to use a nokx software pinned according to a specific release ([`f1adac8`](https://github.com/nokx5/nokxpkgs/commit/f1adac8a37baf923ed4e99f3b6e11fea01df904a)). We illustrate this with the **golden_cpp** software.

```bash
> nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/f1adac8a37baf923ed4e99f3b6e11fea01df904a.tar.gz --pure -p golden_cpp

$ cli_golden_cpp
Welcome to nokx cpp golden project!
```
Nix is an amazing tool ! Give it a try! :ghost:

## How to develop a nokx software

> In order to start developing a nokx software, please refer to the
  specific software documentation if available.

All [nokx](https://github.com/nokx5/) softwares started with a nix
shell script, which by default moved to `default-shell.nix`. This file
is in general using the official **_stable/unstable_ nixpkgs**
channel. The `default.nix` instead appears when the project joined the
**nokxpkgs** channel. Thus two solutions exist to start developing :

 
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
    This command could fail due to the **_unstable_** evolution of the **nixpkgs** channel. However, it should work within the nokxpkgs pinned workflow. You can enter a similar environment than the one created by the `default.nix` by using **nokxpkgs workflow**:
    ```bash
    nix-shell -I nixpkgs=https://github.com/nokx5/nokxpkgs/archive/main.tar.gz default-shell.nix
    ``` 
 
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

### Available nokx software

***
**C/C++ projects**
- [x] [golden_cpp](https://github.com/nokx5/golden_cpp)
***
**Go projects**
***
**Python projects**
- [x] [golden_python_cli](https://github.com/nokx5/golden_python)
- [x] [python3Packages.golden_binding](https://github.com/nokx5/golden_binding)
- [x] [python3Packages.golden_python](https://github.com/nokx5/golden_python)
- [x] [python3Packages.golden_python_cli](https://github.com/nokx5/golden_python)
***
**Rust projects**
***
**Scripts & Automation**
***

### Available nokx documentation

## Use a code formatter
```bash
nixfmt $(find -name "*.nix")
```
