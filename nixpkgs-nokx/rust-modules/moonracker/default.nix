{}:

let
  inherit (rust-self) callPackage;

  inherit (super) stdenv;
  inherit (stdenv) lib;

  mozilla-src = pkgs.fetchFromGitHub {
      owner = "mozilla";
      repo = "nixpkgs-mozilla";
      rev = "9f35c4b09fd44a77227e79ff0c1b4b6a69dff533";
      sha256 = "18h0nvh55b5an4gmlgfbvwbyqj91bklf1zymis6lbdh75571qaz0";
   };

  mozilla-rust-overlay = import "${mozilla-src.out}/rust-overlay.nix" pkgs pkgs;
  rust-nightly = mozilla-rust-overlay.rustChannels.nightly.rust;
  rustc-nightly = mozilla-rust-overlay.rustChannels.nightly.rustc;
  cargo-nightly = mozilla-rust-overlay.rustChannels.nightly.cargo;

in {

  golden_rust = callPackage ./golden_rust { };

  roxy = callPackage ./golden_rust { };

}
