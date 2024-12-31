{
  hostname,
  user,
  lib,
  sudo,
  ...
}:
let
  flake = "/etc/nixos";
  home = "/home/${user}";
in
{
  networking.hostName = hostname;

  time.timeZone = lib.mkDefault "Etc/UTC";

  system.activationScripts = {
    postActivation = {
      text = ''
        stat "${flake}" >/dev/null || \
          ${sudo} ln -s "${home}/nix" "${flake}"

        ${sudo} chown ${user}:users -R "${home}/nix"
      '';
    };
  };

  users.users = {
    ${user} = {
      inherit home;
    };
  };
}
