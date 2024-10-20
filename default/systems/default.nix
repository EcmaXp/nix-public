{ platform, lib, ... }: {
  imports = [
    ./nix.nix
    ./${platform}
  ];

  time.timeZone = lib.mkDefault "Etc/UTC";
}
