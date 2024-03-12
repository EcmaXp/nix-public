{ user, pkgs, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/zed";
  targetPath = "~${user}/.config/zed";
  mkSymlink = filename: ''
    mkdir -p ${targetPath}
    sudo -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${mkSymlink "settings.json"}
        ${mkSymlink "keymap.json"}
        ${mkSymlink "tasks.json"}
      '';
    };
  };
}
