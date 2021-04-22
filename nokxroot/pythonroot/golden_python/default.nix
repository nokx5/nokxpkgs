{ buildPythonApplication, buildPythonPackage, commonMeta, fetchgit
, pytestCheckHook, decorator, jinja2, pyjson5, toml }:

let
  pname = "golden_python";
  version = "0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/golden_python.git";
    rev = version;
    sha256 = "sha256:1bp9ll62g8z1qmvr4zw04arkmyzmahy71pxdzqdv7iqgn3z1lzkd";
  };

  meta = commonMeta // { description = "Golden Project For Pure Python Code"; };

in {

  golden_python = buildPythonPackage rec {
    inherit pname version src meta;

    checkInputs = [ pytestCheckHook ];
    pytestFlagsArray = [ "tests" "-vv" ];

    propagatedBuildInputs = [ decorator jinja2 pyjson5 toml ];

  };

  golden_python_cli = buildPythonApplication rec {
    inherit pname version src meta;

    checkInputs = [ pytestCheckHook pyjson5 toml ];
    pytestFlagsArray = [ "tests" "-vv" ];

    propagatedBuildInputs = [ decorator jinja2 ];

    # outputs = [ "bin" "dev" "doc" "out" ];

    # preInstall = ''
    #   mkdir -p $outputDoc
    #   mkdir -p $outputDoc/share/doc/dflkfld
    #   touch $outputDoc/share/doc/dflkfld/helloworld
    # '';
  };

}
