{ user, ... }:
let
  sourcePath = "~${user}/nix/default/programs/dev/git";
  targetPath = "~${user}";
  mkSymlink = oldFileName: newFileName: ''
    mkdir -p ${targetPath}
    sudo -u ${user} ln -sf ${sourcePath}/${oldFileName} ${targetPath}/${newFileName}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${mkSymlink "git.gitignore" ".gitignore"}
      '';
    };
  };

  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      extraConfig = {
        init.defaultbranch = "main";
        core.excludesfile = "~/.gitignore";
      };
    };
  };
}
