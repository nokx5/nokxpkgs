self:

let
  inherit (self) callPackage stdenv;

  inherit (stdenv) lib;
  pythonPackageOverrides = (import ./pythonroot self);

  all_pkgs = (with self; [ golden_cpp golden_python_cli ])
    ++ (with self.python3Packages; [ golden_binding golden_python ]);

  commonMeta = {
    description = "another nokx software";
    maintainers = with self.config.maintainers; [ nokx ];
    homepage = "https://www.nokx.ch/";
    license = { free = true; };
  };

in super: {

  inherit all_pkgs commonMeta;

  golden_cpp = callPackage ./golden_cpp { stdenv = self.clangStdenv; };
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
