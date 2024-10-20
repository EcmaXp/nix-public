{ user, inputs, pkgs, ... }: {
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
        "konfig"
        "minio"
        "node-shell"
        "rook-ceph"
        "view-secret"
      ];
    };
  };
}
