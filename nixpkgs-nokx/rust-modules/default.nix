rust-self: rust-super:

let
  inherit (rust-super) callPackage lib;

  nightlyPlatform = rust-super.makeRustPlatform {
    rustc = rust-self.latest.rustChannels.nightly.rust;
    cargo = rust-self.latest.rustChannels.nightly.rust;
  };

  all-nokx = with rust-self; [ golden_rust_cli golden_rust_nightly_cli ];

in {
  inherit all-nokx;

  golden_rust_cli = callPackage ./golden_rust { };
  golden_rust_nightly_cli =
    callPackage ./golden_rust { rustPlatform = nightlyPlatform; };

  # requires buildRustCrate
  moonraker = callPackage ./moonraker { rustPlatform = nightlyPlatform; };

}
