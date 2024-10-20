{ user, ... }:
let
  sourcePath = "~${user}/nix/default/programs/editors/nano";
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
