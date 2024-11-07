{ user, sudo, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/terminals/kitty";
  targetPath = "~${user}/.config/kitty";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "kitty.conf"}
        ${mkSymlink "launch-actions.conf"}
        ${mkSymlink "open-actions.conf"}
      '';
    };
  };

  programs.fish = {
    shellInit = ''
      if test "$TERM" = "xterm-kitty"
          function ssh
              kitty +kitten ssh $argv
          end
      end
    '';
    interactiveShellInit = ''
      if test -n "$KITTY_SHELL_INTEGRATION"
        for file in $KITTY_FISH_XDG_DATA_DIR/fish/vendor_completions.d/*.fish
          source $file
        end
        source $KITTY_FISH_XDG_DATA_DIR/fish/vendor_conf.d/kitty-shell-integration.fish
      end
    '';
  };
}
