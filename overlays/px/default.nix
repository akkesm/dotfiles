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
  version = "3.5.1";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = version;
    sha256 = "0j2rgfnrvj83jfl6p6kmpfnqkj088s1f3xngnbsaw4ya10kdy0qs";
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
