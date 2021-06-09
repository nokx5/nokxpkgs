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
    let
      overlay = final: prev:
        import ./classic-overlays/nokx-overlay.nix final prev;
    in utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ];
        };

      in rec {
        packages = pkgs // {
          inherit (golden-cpp.packages.${system}) golden-cpp golden-cpp-clang;
          inherit (golden-pybind11.packages.${system})
            golden-pybind11 golden-pybind11-clang;
          inherit (golden-python.packages.${system})
            golden-python golden-python-app;
          inherit (golden-go.packages.${system}) golden-go;

          all-nokx = (with pkgs; [ speedo ])
            ++ (with pkgs.python3Packages; [ speedo_client ])
            ++ [
              golden-cpp.packages.${system}.golden-cpp
              golden-cpp.packages.${system}.golden-cpp-clang
              golden-pybind11.packages.${system}.golden-pybind11
              golden-pybind11.packages.${system}.golden-pybind11-clang
              golden-python.packages.${system}.golden-python
              golden-python.packages.${system}.golden-python-app
              golden-go.packages.${system}.golden-go
            ];
        };
        defaultPackage = self.packages.${system}.speedo;
      });

}
