{ inputs, user, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${user} = {
      home.stateVersion = "23.11";

      programs = {
        home-manager.enable = true;
      };
    };
  };
}
