{ user, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/nano";
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
        ${mkSymlink "nanorc" ".nanorc"}
      '';
    };
  };
}
