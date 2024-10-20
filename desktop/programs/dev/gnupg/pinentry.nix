{ platform, user, pkgs, lib, ... }: {
  environment.variables = {
    PINENTRY_PROGRAM = "pinentry-mac";
  };
}
