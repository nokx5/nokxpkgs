{
  description = "nokx packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
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
    golden-rust = {
      url = "github:nokx5/golden-rust/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs =
    { self
    , nixpkgs
    , golden-cpp
    , golden-go
    , golden-pybind11
    , golden-python
    , golden-rust
    , rust-overlay
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
          overlays = with self.overlays; [ all-nokx-overlay classic-overlay golden-cpp-overlay golden-go-overlay golden-pybind11-overlay golden-python-overlay rust-overlay.overlay golden-rust-overlay ];
        }
      );

      depsToBuild = name: p: from: p.stdenvNoCC.mkDerivation {
        inherit name;
        src = self;
        buildInputs = from;
        nativeBuildInputs = from;
        installPhase = ''
          mkdir -p $out
          echo "nix show-derivation $out # for full derivation information of $name" > $out/README.md
        '';
      };



    in
    {
      overlays = {
        all-nokx-overlay = final: prev: {
          all-nokx = depsToBuild "all-nokx" prev [
            final.golden-cpp
            final.golden-cpp-clang
            final.golden-go
            final.golden-python-app
            final.golden-rust
            final.golden-rust-nightly
            final.speedo
            final.python3Packages.golden-pybind11
            final.python3Packages.golden-pybind11-clang
            final.python3Packages.golden-python
            final.python3Packages.speedo_client
          ];
          all-nokx-dev = depsToBuild "all-nokx-dev" prev [
            final.golden-cpp.inputDerivation
            final.golden-cpp-clang.inputDerivation
            # final.golden-go.inputDerivation
            final.golden-python-app.inputDerivation
            final.golden-rust.inputDerivation
            final.golden-rust-nightly.inputDerivation
            final.speedo.inputDerivation
            final.python3Packages.golden-pybind11.inputDerivation
            final.python3Packages.golden-pybind11-clang.inputDerivation
            final.python3Packages.golden-python.inputDerivation
            final.python3Packages.speedo_client.inputDerivation
          ];
        };
        classic-overlay = final: prev: (import ./classic-overlays/nokx-overlay.nix) final prev;
        golden-cpp-overlay = golden-cpp.overlay;
        golden-go-overlay = golden-go.overlay;
        golden-pybind11-overlay = golden-pybind11.overlay;
        golden-python-overlay = golden-python.overlay;
        golden-rust-overlay = golden-rust.overlay;

      };
      devShell = forDevSystems (system:
        let pkgs = nixpkgsFor.${system}; in pkgs.callPackage ./shell.nix { }
      );

      hydraJobs = {

        build-all = forDevSystems (system: self.packages.${system}.all-nokx);
        build-all-dev = forDevSystems (system: self.packages.${system}.all-nokx-dev);
        # build-all-dev-full = forDevSystems (system: self.packages.${system}.all-nokx-dev-full);

        release = forDevSystems (system:
          with nixpkgsFor.${system}; releaseTools.aggregate
            {
              name = "nokxpkgs-release";
              constituents =
                [
                  self.hydraJobs.build-all.${system}
                  self.hydraJobs.build-all-dev.${system}
                  # self.hydraJobs.build-all-dev-full.${system}
                ] ++ lib.optionals (hostPlatform.isLinux) [ ];
              meta.description = "hydraJobs: nokxpkgs contains all packages of nokx";
            });

      };

      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          inherit (pkgs) all-nokx all-nokx-dev;
          all-nokx-dev-full =
            if (builtins.elem system devSystems) then
              (depsToBuild "all-nokx-dev-full" pkgs
                [
                  golden-cpp.devShell.${system}.inputDerivation
                  golden-go.devShell.${system}.inputDerivation
                  golden-python.devShell.${system}.inputDerivation
                  golden-pybind11.devShell.${system}.inputDerivation
                  golden-rust.devShell.${system}.inputDerivation
                  self.devShell.${system}.inputDerivation
                ]) else pkgs.all-nokx-dev;
        }
      );

      inherit nixpkgsFor;
    };
}
