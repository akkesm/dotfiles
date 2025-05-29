{ lib
, buildPythonApplication
, fetchFromGitHub
, git
, procps
, pytest
, python-dateutil
}:

buildPythonApplication rec {
  pname = "px";
  version = "3.6.10";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "15xkpmymf0g0mqhjc6mswymrqkilbys3mkhz1xk9lq3jilfhdm04";
  };

  nativeBuildInputs = [
    git
  ];

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
