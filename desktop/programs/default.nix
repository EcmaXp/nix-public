{ ... }: {
  imports = [
    ./dev/git
    ./dev/gnupg
    ./dev/rage.nix
    ./zed
    ./karabiner
    ./kitty
    ./nix
    ./shells/fish.nix
    ./shells/shell-plugins.nix
    ./shells/shells.nix
    ./shells/starship.nix
    # TODO: raycast
    # TODO: Karabiner-Elements
  ];
}
