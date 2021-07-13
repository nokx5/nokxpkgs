{
  description = "nokx packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    golden-cpp = {
      url = "github:nokx5/golden-cpp/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    golden-go = {
      url = "github:nokx5/golden-go/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    golden-pybind11 = {
      url = "github:nokx5/golden-pybind11/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    golden-python = {
      url = "github:nokx5/golden-python/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, golden-cpp, golden-go, golden-pybind11
    , golden-python }:
      utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ (import ./classic-overlays/nokx-overlay.nix) golden-cpp.overlay golden-go.overlay golden-python.overlay ];
        };

      in rec {
        packages = pkgs // {
          inherit (golden-pybind11.packages.${system})
            golden-pybind11 golden-pybind11-clang;

          all-nokx = (with pkgs; [ golden-cpp golden-cpp-clang golden-go golden-python golden-python-app speedo ])
            ++ (with pkgs.python3Packages; [ speedo_client ])
            ++ [
              golden-pybind11.packages.${system}.golden-pybind11
              golden-pybind11.packages.${system}.golden-pybind11-clang
            ];
        };
        defaultPackage = self.packages.${system}.speedo;
      });

}
