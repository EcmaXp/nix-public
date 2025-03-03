{ user, sudo, ... }:
let
  mkSymlink = sourcePath: targetPath: ''
    ${sudo} -u ${user} ln -sf ${sourcePath} ${targetPath}
  '';
in
{
  imports = [
    ./configuration.nix
  ];

  system.activationScripts = {
    postUserActivation = {
      text = ''
        stat "/home/${user}/nix" >/dev/null || \
          ${mkSymlink "/Users/${user}/nix" "/home/${user}/nix"}
      '';
    };
  };
}
