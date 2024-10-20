{ user, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/windows/aerospace";
  targetPath = "~${user}";
  mkSymlink = oldFileName: newFileName: ''
    mkdir -p ${targetPath}
    sudo -u ${user} ln -sf ${sourcePath}/${oldFileName} ${targetPath}/${newFileName}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${mkSymlink "aerospace.toml" ".aerospace.toml"}
      '';
    };
  };
}
