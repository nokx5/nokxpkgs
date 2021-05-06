[
  #   ./lib-overlay.nix
  "${builtins.fetchurl
  "https://raw.githubusercontent.com/mozilla/nixpkgs-mozilla/master/rust-overlay.nix"}" # rust nightly overlay
  ./nokx-overlay.nix
]
