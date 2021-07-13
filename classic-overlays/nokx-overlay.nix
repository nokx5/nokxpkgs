self: super:

let
  inherit (super) callPackage;
  pythonPackageOverrides = python-self: python-super:
    let inherit (python-self) callPackage;
    in { inherit (callPackage ./speedo { }) speedo speedo_client; };

in
{

  python37 = super.python37.override (old: {
    packageOverrides =
      super.lib.composeExtensions (old.packageOverrides or (_: _: { }))
        pythonPackageOverrides;
  });
  python38 = super.python38.override (old: {
    packageOverrides =
      super.lib.composeExtensions (old.packageOverrides or (_: _: { }))
        pythonPackageOverrides;
  });
  python39 = super.python39.override (old: {
    packageOverrides =
      super.lib.composeExtensions (old.packageOverrides or (_: _: { }))
        pythonPackageOverrides;
  });

  speedo = super.python3Packages.speedo;

}
