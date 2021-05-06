{ commonMeta, lib, fetchgit, buildPythonPackage, buildPythonApplication, fastapi
, prometheus_client, pycurl, pydantic, pytestCheckHook, sqlalchemy-utils
, uvicorn, alembic, mock }:

let
  version = "1.0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/speedo.git";
    rev = "75c59ddadd51116a1dd3c3636f8c7247eebeb370";
    sha256 = "sha256:0q49pyizsgjgd1kjmdbn545n2qj23i3y8kqs1893f8fxpa2hfx98";
  };

  checkInputs = [ pytestCheckHook mock fastapi prometheus_client ];

in {
  speedo_client = buildPythonPackage rec {
    pname = "speedo_client";
    inherit version src checkInputs;
    SPEEDO_TARGET = "client";

    propagatedBuildInputs = [ pycurl pydantic ];

    pytestFlagsArray = [ "tests/client" ];

    meta = commonMeta // { description = "Speedo python client"; };
  };

  speedo = buildPythonApplication rec {
    pname = "speedo";
    inherit version src checkInputs;
    SPEEDO_TARGET = "server";

    propagatedBuildInputs =
      [ fastapi prometheus_client sqlalchemy-utils uvicorn alembic ];

    pytestFlagsArray = [ "tests/server" ];

    meta = commonMeta // { description = "Speedo server"; };
  };
}
