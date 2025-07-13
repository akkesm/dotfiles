{ lib
, buildPythonApplication
, fetchFromGitHub
, git
, procps
, pytest
, python-dateutil
, setuptools
}:

buildPythonApplication rec {
  pname = "px";
  version = "3.6.12";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "06jg6izya1k5gk71pygv8691fcaa6zfnzns57fjknnihz3c42pzw";
  };

  build-system = [ setuptools ];

  nativeBuildInputs = [ git ];

  buildInputs = [ procps ];
  checkInputs = [ pytest ];
  propagatedBuildInputs = [ python-dateutil ];

  # Tests want "/bin/ps"
  doCheck = false;

  preBuild = ''
    substituteInPlace ./setup.py \
      --replace-fail '"pytest-runner",' ' '

    substituteInPlace ./px/px_process.py \
      --replace-fail '"/bin/ps"' '"${procps}/bin/ps"'
  '';

  meta = with lib; {
    description = "ps and top for human beings";
    homepage = "https://github.com/walles/px";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
