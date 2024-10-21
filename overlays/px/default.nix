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
  version = "3.6.5";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "0zhh3y8caww6rxy9ppg60ls1505s5z1jmnahr5v31r94vzlp4h8v";
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
      --replace-fail 'subprocess.check_output(["git", "describe", "--dirty"]).decode("utf-8").strip()' '"${version}"'

    substituteInPlace ./setup.py \
      --replace-fail '"pytest-runner",' ' '

    substituteInPlace ./devbin/update_version_py.py \
      --replace-fail 'subprocess.check_output(["git", "describe", "--dirty"]).decode("utf-8").strip()' '"${version}"'

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
