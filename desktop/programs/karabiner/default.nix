{ platform, ... }:
if platform == "darwin" then {
  homebrew = {
    casks = [
      "karabiner-elements"
    ];
  };
} else { }
