rust-self: rust-super:

let
  inherit (rust-super) callPackage lib;

  # all-nokx = with rust-self; [ golden_rust ];

in {
  # inherit all-nokx;

  golden_rust = callPackage ./golden_rust { };

}
