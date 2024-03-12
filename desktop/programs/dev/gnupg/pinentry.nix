{ platform, user, lib, pkgs, ... }:
if platform == "darwin" then
  let
    pinentry_program = "${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";
  in
  {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        pinentry_mac
      ];

      services.gpg-agent.extraConfig = "pinentry-program ${pinentry_program}";
    };

    environment.variables = {
      PINENTRY_PROGRAM = pinentry_program;
    };
  }
else { }
