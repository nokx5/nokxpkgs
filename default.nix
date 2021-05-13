{ }:

let

  # all standard upstream packages
  pinned-pkgs = builtins.fetchTarball {
    # example source: https://github.com/NixOs/nixpkgs/archive/nixpkgs-unstable/0b14ea44a62b4724dc27ad70e4a6181a3d912c94.tar.gz";
    # - get the SHA256 hash using: nix-prefetch-url --unpack <url>
    url =
      "https://github.com/NixOs/nixpkgs/archive/nixpkgs-unstable/main.tar.gz";
    sha256 = "sha256:15bpsggh9zz9gk7c1sfp6bwrgcadddxhknd7m8gh4k8spf1c1qfk";
  };

in import pinned-pkgs {
  overlays = (map (x: import x) [ ./nokx-overlay.nix ]);
  config.allowUnfree = true;
}

