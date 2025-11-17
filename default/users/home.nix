{ username, platform, ... }:
{
  imports = [
    ./default.nix
  ];

  home.username = username;
  home.homeDirectory =
    {
      nixos = "/home/${username}";
      darwin = "/Users/${username}";
    }
    .${platform};
}
