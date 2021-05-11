{ }:

let

  # all standard upstream packages
  pinned-pkgs = builtins.fetchTarball {
    # example source: https://github.com/nixos/nixpkgs/archive/c00959877fb06b09468562518b408acda886c79e.tar.gz";
    # - get the SHA256 hash using: nix-prefetch-url --unpack <url>
    url =
      "https://github.com/NixOS/nixpkgs/archive/eb7e1ef185f6c990cda5f71fdc4fb02e76ab06d5.tar.gz";
    sha256 = "1ibz204c41g7baqga2iaj11yz9l75cfdylkiqjnk5igm81ivivxg";
  };

in import pinned-pkgs { overlays = (map (x: import x) [ ./nixpkgs-nokx ]); }

