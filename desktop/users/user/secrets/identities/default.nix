hostName:
let
  machineIdentityPaths = (if hostName != null then [
    ./${hostName}.se
  ] else [ ]);
  publicMachineIdentityPaths = [
    ./host.se.pub
  ];
  yubikeyIdentityPaths = [
    ./yubikey-example.yubikey
  ];
  publicyYubikeyIdentityPaths = [
    ./yubikey-example.ssh.pub
    ./yubikey-example.yubikey.pub
  ];
  identityPaths = (
    machineIdentityPaths
    ++ yubikeyIdentityPaths
  );
  publicIdentityPaths = (
    publicMachineIdentityPaths
    ++ publicyYubikeyIdentityPaths
  );
in
{
  identityPaths = identityPaths;
  publicKeys = (
    builtins.map
      (file: builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile file))
      publicIdentityPaths
  );
}
