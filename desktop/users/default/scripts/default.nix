{
  imports = [
    ./nix
  ];

  home.scripts = {
    desktop = {
      bin = ./bin;
      fish = ./fish;
    };
  };
}
