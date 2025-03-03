{
  config,
  system,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  age-plugin-se = pkgs.stdenv.mkDerivation rec {
    pname = "age-plugin-se";
    version = "1.0.0";

    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      ln -s ${config.homebrew.brewPrefix}/${pname} $out/bin
    '';

    meta = {
      mainProgram = pname;
    };
  };

  age-plugins =
    (with pkgs; [
      age-plugin-yubikey
    ])
    ++ [
      age-plugin-se
    ];

  ragenix = inputs.ragenix.packages.${system}.default.override {
    plugins = age-plugins;
  };

  age-wrapper = name: final: prev: {
    ${name} = prev.${name}.overrideAttrs (old: {
      nativeBuildInputs = old.nativeBuildInputs ++ [
        prev.makeWrapper
      ];

      postFixup = ''
        wrapProgram "$out/bin/${old.meta.mainProgram}" \
          --suffix PATH : ${lib.strings.makeBinPath age-plugins}
      '';
    });
  };
in
{
  environment.systemPackages = [
    ragenix
  ];

  nixpkgs.overlays = [
    (age-wrapper "age")
    (age-wrapper "rage")
  ];

  age = {
    ageBin = lib.getExe pkgs.rage;
  };
}
