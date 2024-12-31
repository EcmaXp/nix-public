{
  user,
  pkgs,
  lib,
  ...
}:
{
  environment.enableAllTerminfo = true;

  system.activationScripts = {
    postUserActivation = {
      text = ''
        TERMINFO_DIRS=${pkgs.kitty.terminfo}/share/terminfo \
          ${lib.getExe' pkgs.ncurses "infocmp"} -a xterm-kitty | \
          ${lib.getExe' pkgs.ncurses "tic"} -x -o ~${user}/.terminfo /dev/stdin 2>/dev/null
      '';
    };
  };
}
