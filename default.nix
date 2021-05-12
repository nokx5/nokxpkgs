{ }:

let

  # all standard upstream packages
  pinned-pkgs = builtins.fetchTarball {
    # example source: https://github.com/nixos/nixpkgs/archive/c00959877fb06b09468562518b408acda886c79e.tar.gz";
    # - get the SHA256 hash using: nix-prefetch-url --unpack <url>
    url =
      "https://github.com/NixOS/nixpkgs/archive/8a0c5da648702f4620e3a2926f48b38dd1d86562.tar.gz";
    sha256 = "0y84yknvgkkchkdpydh7klq4kfi73mzb5g7830xd17gzjj5chav9";
  };

in import pinned-pkgs { overlays = (map (x: import x) [ ./nixpkgs-nokx ]); }

