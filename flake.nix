{
  description = "nokx packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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

  outputs =
    { self
    , nixpkgs
    , golden-cpp
    , golden-go
    , golden-pybind11
    , golden-python
    }:
    let
      forCustomSystems = custom: f: nixpkgs.lib.genAttrs custom (system: f system);
      allSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" ];
      devSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = forCustomSystems allSystems;
      forDevSystems = forCustomSystems devSystems;

      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = with self.overlays; [ classic-overlay golden-cpp-overlay golden-go-overlay golden-pybind11-overlay golden-python-overlay ];
        }
      );

    in
    {
      overlays = {
        classic-overlay = final: prev: (import ./classic-overlays/nokx-overlay.nix) final prev;
        golden-cpp-overlay = golden-cpp.overlay;
        golden-go-overlay = golden-go.overlay;
        golden-pybind11-overlay = golden-pybind11.overlay;
        golden-python-overlay = golden-python.overlay;
      };
      devShell = forDevSystems (system:
        let pkgs = nixpkgsFor.${system}; in pkgs.callPackage ./shell.nix { }
      );

      packages = forAllSystems
        (system:
          let pkgs = nixpkgsFor.${system}; in
          rec {
            all-nokx = pkgs.stdenvNoCC.mkDerivation {
              name = "all-nokx";
              src = self;
              nativeBuildInputs = [ pkgs.golden-cpp pkgs.golden-cpp-clang pkgs.golden-go pkgs.golden-python-app pkgs.speedo pkgs.python3Packages.golden-pybind11 pkgs.python3Packages.golden-pybind11-clang pkgs.python3Packages.golden-python pkgs.python3Packages.speedo_client ];
              installPhase = ''
                mkdir -p $out
                echo "nix show-derivation $out # for full derivation information" > $out/README.md
              '';
            };
            all-nokx-dev =
              if (builtins.elem system devSystems) then
                pkgs.stdenvNoCC.mkDerivation
                  {
                    name = "all-nokx-dev";
                    src = self;
                    nativeBuildInputs = [
                      golden-cpp.devShell.${system}.inputDerivation
                      golden-go.devShell.${system}.inputDerivation
                      golden-python.devShell.${system}.inputDerivation
                      golden-pybind11.devShell.${system}.inputDerivation
                      self.devShell.${system}.inputDerivation
                    ];
                    installPhase = ''
                      mkdir -p $out
                      echo "nix show-derivation $out # for full derivation information" > $out/README.md
                    '';
                  } else all-nokx;
          });

    };
}
