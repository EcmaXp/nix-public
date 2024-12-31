{ user, pkgs, ... }:
let
  toolgit =
    with pkgs;
    stdenv.mkDerivation {
      pname = "toolgit";
      version = "0.0.0";

      src = fetchFromGitHub {
        owner = "ahmetsait";
        repo = "toolgit";
        rev = "8cb83ba981273fd866e0db72695dce2195382fd6"; # = 2024-12-04
        sha256 = "h19chGRl8Ve1abbBdkUtIAEWyJrJ0eepwXqUKGwpqxc=";
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
