{
  description = "nokx packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let overlay = final: prev: import ./nokx-overlay.nix final prev;
    in {
      overlay = final: prev: overlay final prev;
    } // utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" ]
    (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ];
        };

      in rec {
        defaultPackage = pkgs.golden_cpp;
        packages = pkgs;
      });

}
