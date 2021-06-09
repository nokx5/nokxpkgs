self: super:

let
  inherit (super) callPackage lib;

  nokx-dev = (with self; [ emacs-nox nix git typora ]);
  nokx-doc = (with self; [ hugo jekyll plantuml ]);

  commonMeta = {
    description = "another nokx software";
    maintainers = with self.config.maintainers; [ nokx ];
    homepage = "https://www.nokx.ch/";
    license = { free = true; };
  };

  pythonPackageOverrides = import ./python-modules;

in {
  inherit commonMeta;

  nokx-tools = nokx-dev ++ nokx-doc;

  all-nokx = (with self;
    [ golden-cpp golden-python_cli speedo ] ++ python3Packages.all-nokx);

  golden-cpp = callPackage ./golden-cpp { };
  golden-python_cli = super.python3Packages.golden-python_cli;

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

  speedo = super.python3Packages.speedo;

}
