{ user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${user} = {
      home.stateVersion = "24.11";

      programs.home-manager.enable = true;
    };
  };
}
