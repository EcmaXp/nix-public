{ hostname, user, sudo, ... }:
let
  flake = "/etc/nixos";
  home = "/home/${user}";
in
{
  networking.hostName = hostname;

  system.activationScripts = {
    postActivation = {
      text = ''
        stat "${flake}" >/dev/null || \
          ${sudo} ln -s "${home}/nix" "${flake}"
      '';
    };
  };

  users.users = {
    ${user} = {
      inherit home;
    };
  };
}
