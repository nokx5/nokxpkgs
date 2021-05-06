rust-self: rust-super:

let
  inherit (rust-super) callPackage lib;

  all-nokx = with rust-self; [ golden_rust_cli moonracker ];

in {
  inherit all-nokx;

  golden_rust_cli = callPackage ./golden_rust { };

  moonracker = callPackage ./moonracker {
    rustSpecific = rust-self.latest.rustChannels.nightly.rust;
  };

}
