inputs: system: profile: { user, modules ? [ ] }:
let
  pkgs = inputs.nixpkgs.outputs.legacyPackages.${system};
  pkgs-stable = inputs.nixpkgs-stable.outputs.legacyPackages.${system};
  pkgs-unstable = inputs.nixpkgs-unstable.outputs.legacyPackages.${system};
  platform = "darwin";
  hostname = (
    builtins.readFile (pkgs.runCommand "hostname" { } ''
      /usr/sbin/scutil --get LocalHostName | /usr/bin/tr -d '\n' > $out
    '').outPath
  );
in
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit platform;
    inherit system;
    inherit hostname;
    inherit user;
    inherit inputs;
    inherit pkgs-stable;
    inherit pkgs-unstable;
    inherit (inputs) self;
  };
  modules = profile.modules ++ modules;
}
