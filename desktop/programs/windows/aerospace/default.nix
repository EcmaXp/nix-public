{ user, sudo, ... }:
let
  sourcePath = "~${user}/nix/desktop/programs/windows/aerospace";
  targetPath = "~${user}";
  mkSymlink = oldFileName: newFileName: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${oldFileName} ${targetPath}/${newFileName}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "aerospace.toml" ".aerospace.toml"}
      '';
    };
  };
}
