{ lib
, buildPythonApplication
, fetchFromGitHub
, git
, procps
, pytest
, pytest-runner
, python-dateutil
}:

buildPythonApplication rec {
  pname = "px";
  version = "3.5.3";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "1hcnbq03gx194zr942p062w6fl3lkaiyx9w4hyfac6qgkn4yzr6n";
  };

  nativeBuildInputs = [
    git
    pytest-runner
  ];

  buildInputs = [ procps ];
  checkInputs = [ pytest ];
  propagatedBuildInputs = [ python-dateutil ];

  # Tests want "/bin/ps"
  doCheck = false;

  preBuild = ''
    substituteInPlace ./setup.py \
      --replace 'subprocess.check_output(["git", "describe", "--dirty"]).decode("utf-8").strip()' '"${version}"'

    substituteInPlace ./px/px_process.py \
      --replace '"/bin/ps"' '"${procps}/bin/ps"'
  '';

  meta = with lib; {
    description = "ps and top for human beings";
    homepage = "https://github.com/walles/px";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
