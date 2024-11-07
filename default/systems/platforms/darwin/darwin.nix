{ hostname, user, sudo, ... }:
let
  flake = "/etc/nix-darwin";
  home = "/Users/${user}";
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
