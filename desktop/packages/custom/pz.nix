{ pkgs, ... }:
with pkgs;
python3Packages.buildPythonPackage rec {
  pname = "pz";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "CZ-NIC";
    repo = "pz";
    rev = version;
    sha256 = "05hljmqrzqbm0gqif4azs256x3qw6lzmav65d7j710651dqhkv1w"; # 1.1.0
  };

  meta = {
    homepage = "https://github.com/CZ-NIC/pz";
  };
}
