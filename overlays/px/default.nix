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
  version = "3.4.0";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "0fm64ggqz3gpnqqni9pv75bianjva0qzfdn1h89a2zz4lvgyplg5";
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
