[
  # ./lib-overlay.nix
  # rust nightly overlay
  "${builtins.fetchurl
  "https://raw.githubusercontent.com/mozilla/nixpkgs-mozilla/8c007b60731c07dd7a052cce508de3bb1ae849b4/rust-overlay.nix"}"
  ./nokx-overlay.nix
]
