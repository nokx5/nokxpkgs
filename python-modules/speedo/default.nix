{ commonMeta, lib, fetchgit, buildPythonPackage, buildPythonApplication, alembic
, fastapi, mock, prometheus_client, pycurl, pydantic, pytestCheckHook
, sqlalchemy-utils, uvicorn }:

let
  version = "1.0";

  src = fetchgit {
    url = "https://github.com/nokx5/speedo.git";
    rev = version;
    sha256 = "sha256:1akxlgc5gjl9b7y4w01jqazm5ra206mvzvyn11vzzx8jds4k6qzw";
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
