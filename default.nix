{ }:

let

  # all standard upstream packages
  nokxpkgs = builtins.fetchTarball {
    # example source: https://github.com/nixos/nixpkgs/archive/c00959877fb06b09468562518b408acda886c79e.tar.gz";
    url =
      "https://github.com/NixOS/nixpkgs/archive/c7e905b6a971dad2c26a31960053176c770a812a.tar.gz";
    sha256 = "1h0npga8nlbmv2fnirmv8v5xs8xd3k7hn803lxjn09hyqdcxx23n";
  };

in import nokxpkgs {
  overlays = (map (x: import x) [ ./nixpkgs-nokx ./nixpkgs-cherix ]);
}

