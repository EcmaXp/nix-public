{ user, pkgs, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/yabai";
  targetPath = "~${user}/";
  mkSymlink = filename: ''
    sudo -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${mkSymlink ".yabairc"}
      '';
    };
  };

  # You need to setup visudo to allow yabai to run as root
  # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
}
