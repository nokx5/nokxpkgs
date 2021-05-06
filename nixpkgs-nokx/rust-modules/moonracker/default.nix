{ lib, commonMeta, fetchgit, rustPlatform, rustSpecific }:

rustPlatform.buildRustPackage rec {
  cargo = rustSpecific;
  rustc = rustSpecific;

  pname = "moonracker";
  version = "0.0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/golden_rust.git";
    rev = "b416305b23044cb27a6f9801e968865a7ac9d8e4";
    sha256 = "sha256:1nzlkh41y3y80wdcm6sr8hsbxakjajvygidkwv361g0771g8m0c5";
  };

  buildInputs = [ ];

  nativeBuildInputs = [ ];

  cargoSha256 = "01l2910x6r2z5vsdakz4m7xrzfnrkji6k3x8l5spkk2nqnzcby50";

  meta = commonMeta // { description = "Golden Project For Rust Code"; };
}
