self: super:

let
  inherit (super) callPackage lib;

  commonMeta = {
    description = "another nokx software";
    maintainers = with self.config.maintainers; [ nokx ];
    homepage = "https://www.nokx.ch/";
    license = { free = true; };
  };

  pythonPackageOverrides = import ./python-modules;

in {
  inherit commonMeta;

  all-nokx =
    (with self; [ golden_cpp golden_python_cli ] ++ python3Packages.all-nokx);

  golden_cpp = callPackage ./golden_cpp { };
  golden_python_cli = super.python3Packages.golden_python_cli;

  python37 = super.python37.override (old: {
    packageOverrides =
      super.stdenv.lib.composeExtensions (old.packageOverrides or (_: _: { }))
      pythonPackageOverrides;
  });
  python38 = super.python38.override (old: {
    packageOverrides =
      super.stdenv.lib.composeExtensions (old.packageOverrides or (_: _: { }))
      pythonPackageOverrides;
  });
  python39 = super.python39.override (old: {
    packageOverrides =
      super.stdenv.lib.composeExtensions (old.packageOverrides or (_: _: { }))
      pythonPackageOverrides;
  });

}
