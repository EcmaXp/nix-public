{ user, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/editors/zed";
  targetPath = "~${user}/.config/zed";
  mkSymlink = oldFileName: newFileName: ''
    mkdir -p ${targetPath}
    sudo -u ${user} ln -sf ${sourcePath}/${oldFileName} ${targetPath}/${newFileName}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${mkSymlink "settings.json5" "settings.json"}
        ${mkSymlink "keymap.json5" "keymap.json"}
        ${mkSymlink "tasks.json5" "tasks.json"}
      '';
    };
  };

  home-manager.users.${user} = {
    programs.fish = {
      interactiveShellInit = ''
        if test "$ZED_TERM" = "true" -a "$TERM" = "alacritty" -a -z "$__ZED_LANG_PATCHED"
          set -x __ZED_LANG_PATCHED 1
          if test "$LANG" = "" -a "$LC_ALL" = "en_US.UTF-8" -a "$LC_CTYPE" = "en_US.UTF-8"
            set -gx LANG "ko_KR.UTF-8"
            set -e LC_ALL LC_CTYPE
          end
        end
      '';
    };
  };
}
