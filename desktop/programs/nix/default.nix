{ platform, system, self, ... }: {
  nixpkgs.config.allowBroken = true;
  nixpkgs.hostPlatform = system;
  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = if system == "aarch64-darwin" then "extra-platforms = x86_64-darwin" else null;
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  programs.nix-index.enable = true;
} // (if platform == "darwin" then {
  system.stateVersion = 4;
  system.configurationRevision = self.rev or self.dirtyRev or null;
} else { })
