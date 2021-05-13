{
  description = "nokx packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let overlay = import ./.;
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

        legacyPackages = pkgs;

        defaultPackage =
          self.legacyPackages.${system}.git; # (self.overlay self.packages self.packages).golden_cpp;

        # packages = pkgs.lib.extend (_: pkgs) (import ./nixpkgs-nokx/nokx-overlay.nix) pkgs;

        packages = { inherit (pkgs) golden_cpp; };

        ###
      }
      # import ./nixpkgs-nokx
      # packages = forAllSystems (system:
      #   with import nixpkgs { inherit system; };
      #   callPackage ./default.nix { }).all-nokx;
      # defaultPackages =
      # devShell =
      # overlay = import ./nixpkgs-nokx;              
    );

}
