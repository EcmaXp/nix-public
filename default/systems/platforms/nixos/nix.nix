{ self, ... }: {
  system = {
    stateVersion = "24.05"; # Did you read the document?
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = [ "18:00" ];
    };
  };
}
