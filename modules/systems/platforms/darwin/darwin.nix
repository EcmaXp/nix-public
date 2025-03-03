{
  hostname,
  user,
  lib,
  sudo,
  ...
}:
let
  flake = "/etc/nix-darwin";
  home = "/Users/${user}";
in
{
  networking.hostName = hostname;

  time.timeZone = lib.mkDefault "GMT";

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
