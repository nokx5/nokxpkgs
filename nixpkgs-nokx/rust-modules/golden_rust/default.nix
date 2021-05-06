{ lib, commonMeta, fetchgit, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "golden_rust";
  version = "0.0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/golden_rust.git";
    rev = "b416305b23044cb27a6f9801e968865a7ac9d8e4";
    sha256 = "sha256:1nzlkh41y3y80wdcm6sr8hsbxakjajvygidkwv361g0771g8m0c5";
  };

  buildInputs = [ ];

  nativeBuildInputs = [ ];

  cargoSha256 = "08n7jhpyw7kd0rrzw0q2m6xsjsij3i5bzyp1dxc6v1mwvw3l7ax7";

  meta = commonMeta // { description = "Golden Project For Rust Code"; };

}

