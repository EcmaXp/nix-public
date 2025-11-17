{ system, ... }:
{
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  nixpkgs = {
    hostPlatform = system;
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
