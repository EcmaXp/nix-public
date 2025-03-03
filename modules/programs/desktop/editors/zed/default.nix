{
  user,
  sudo,
  pkgs,
  lib,
  ...
}:
let
  sourcePath = "~${user}/nix/modules/programs/desktop/editors/zed";
  targetPath = "~${user}/.config/zed";
  mkSymlink = oldFileName: newFileName: ''
    ${sudo} -u ${user} ${lib.getExe' pkgs.coreutils "ln"} -nsf ${sourcePath}/${oldFileName} ${targetPath}/${newFileName}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "snippets" "snippets"}
        ${mkSymlink "themes" "themes"}
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
