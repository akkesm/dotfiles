{ lib
, buildPythonApplication
, fetchFromGitHub
, git
, procps
, pytest
, python-dateutil
, setuptools-scm
}:

buildPythonApplication rec {
  pname = "px";
  version = "3.8.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "0cnqqi5d81hbhy5pg7cykbn4rbyplhq07r2x8bx64qn1rw7dl93h";
  };

  build-system = [ setuptools-scm ];

  nativeBuildInputs = [ git ];

  buildInputs = [ procps ];
  checkInputs = [ pytest ];
  propagatedBuildInputs = [ python-dateutil ];

  preBuild = ''
    substituteInPlace ./px/px_process.py \
      --replace-fail '"/bin/ps"' '"${procps}/bin/ps"'
  '';

  meta = with lib; {
    description = "ps, top and pstree for human beings";
    homepage = "https://github.com/walles/px";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
