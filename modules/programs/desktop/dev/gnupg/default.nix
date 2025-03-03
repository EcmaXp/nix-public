{ user, sudo, ... }:
let
  sourcePath = "~${user}/nix/modules/programs/desktop/dev/gnupg";
  targetPath = "~${user}/.gnupg";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  imports = [
    ./pinentry.nix
  ];

  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "gpg-agent.conf"}
      '';
    };
  };

  programs.gnupg.agent.enable = true;
}
