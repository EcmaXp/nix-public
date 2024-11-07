{ user, pkgs, ... }:
let
  toolgit = with pkgs; stdenv.mkDerivation {
    pname = "toolgit";
    version = "0.0.0";

    src = fetchFromGitHub {
      owner = "ahmetsait";
      repo = "toolgit";
      rev = "a6818362cef46bf25a0b3eece356030666b2bdc1"; # = 2024-11-04
      sha256 = "DdS385QMqu0ZOK5X4VTGGFyKd2xG3jpqmJM7hTkMsRk=";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp git-* mode-restore.sh $out/bin

      mkdir -p $out/share/toolgit
      cp aliases.ini $out/share/toolgit
    '';

    meta = {
      homepage = "https://github.com/ahmetsait/toolgit";
    };
  };
in
{
  home-manager.users.${user} = {
    home.packages = [
      toolgit
    ];
    programs.git = {
      includes = [
        { path = "${toolgit}/share/toolgit/aliases.ini"; }
      ];
    };
  };
}
