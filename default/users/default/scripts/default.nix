{
  imports = [
    ./nix
  ];

  home.scripts = {
    default = {
      bin = ./bin;
      fish = ./fish;
    };
  };
}
