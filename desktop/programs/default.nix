{ ... }: {
  imports = [
    ./dev/git
    ./dev/gnupg
    ./dev/rage.nix
    ./zed
    ./karabiner
    ./kitty
    ./nix
    ./yabai
    ./shells/fish.nix
    ./shells/shell-plugins.nix
    ./shells/shells.nix
    ./shells/starship.nix
  ];
}
