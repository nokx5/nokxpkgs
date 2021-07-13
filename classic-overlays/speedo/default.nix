{ lib
, fetchgit
, buildPythonPackage
, buildPythonApplication
, alembic
, fastapi
, mock
, prometheus_client
, pycurl
, pydantic
, pytestCheckHook
, sqlalchemy-utils
, uvicorn
}:

let
  version = "23d42bd6148eef845d7f11c992b17ae1bc2fbd6d";

  src = fetchgit {
    url = "https://github.com/nokx5/speedo.git";
    rev = version;
    sha256 = "sha256:GOAH1hRD/nUywkkziyy7R8guwDd6+jGkf1aM/eoQlAo=";
  };

  checkInputs =
    [ pytestCheckHook mock fastapi prometheus_client sqlalchemy-utils ];

in
{
  speedo_client = buildPythonPackage rec {
    pname = "speedo_client";
    inherit version src checkInputs;
    SPEEDO_TARGET = "client";

    propagatedBuildInputs = [ pycurl pydantic ];

    pytestFlagsArray = [ "tests/client" ];
  };

  speedo = buildPythonApplication rec {
    pname = "speedo";
    inherit version src checkInputs;
    SPEEDO_TARGET = "server";

    propagatedBuildInputs =
      [ fastapi prometheus_client sqlalchemy-utils uvicorn alembic ];

    pytestFlagsArray = [ "tests/server" ];
  };
}
