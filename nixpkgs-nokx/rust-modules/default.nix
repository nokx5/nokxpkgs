rust-self: rust-super:

let
  inherit (rust-super) callPackage lib;

  all-nokx = with rust-self; [ golden_rust_cli moonraker ];

in {
  inherit all-nokx;

  golden_rust_cli = callPackage ./golden_rust { };

  moonraker = callPackage ./moonraker {
    rustSpecific = rust-self.latest.rustChannels.nightly.rust;
  };

}
