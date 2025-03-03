{
  user,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    imports = [
      inputs.krewfile.homeManagerModules.krewfile
    ];

    programs.krewfile = {
      enable = true;
      krewPackage = pkgs.krew;
      indexes = {
        default = "https://github.com/kubernetes-sigs/krew-index.git";
      };
      plugins = [
        "kluster-capacity"
        "konfig"
        "krew"
        "minio"
        "node-shell"
        "rook-ceph"
        "sniff"
        "view-secret"
      ];
    };
  };
}
