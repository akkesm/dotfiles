{lib, mkYarnPackage, fetchFromGitHub }:

mkYarnPackage rec {
  pname = "yaml-language-server";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "redhat-developer";
    repo = "yaml-language-server";
    rev = version;
    sha256 = "10b7h568p5dbfvgpypmfpalb3l404rjpwrhl35np0q6fvxa560f5";
  };

  meta = with lib; {
    description = " Language Server for Yaml Files";
    homepage = "https://github.com/redhat-developer/yaml-language-server";
    license = licenses.mit;
  };
}
