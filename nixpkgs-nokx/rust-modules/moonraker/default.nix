{ lib, commonMeta, fetchgit, rustPlatform, rustSpecific }:

rustPlatform.buildRustPackage rec {
  cargo = rustSpecific;
  rustc = rustSpecific;

  pname = "moonraker";
  version = "0.0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/moonraker.git";
    rev = "e603ef717b165a4145782ebd676bdf7cd221b4ee";
    sha256 = "sha256:1nzlkh41y3y80wdcm6sr8hsbxakjajvygidkwv361g0771g8m0c5";
  };

  buildInputs = [ ];

  nativeBuildInputs = [ ];

  cargoSha256 = "1d77nwk4kagdfh1g7v7wmk8pnhqw5r96p602bl0fivb26clq0wzr";

  meta = commonMeta // { description = "Golden Project For Rust Code"; };
}
