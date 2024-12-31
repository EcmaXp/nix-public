{ user, ... }:
{
  imports = [
    ./kubeswitch
    ./safe-rm
    ./starship
    ./tfswitch
  ];

  home-manager.users.${user} = {
    programs.broot.enable = true;
    programs.carapace.enable = true;
    programs.direnv.enable = true;
    programs.eza.enable = true;
    programs.eza.git = true;
    programs.fzf.enable = true;
    programs.mcfly.enable = true;
    programs.navi.enable = true;
    programs.skim.enable = true;
    programs.tmux.enable = true;
    programs.watson.enable = true;
    programs.yazi.enable = true;
    programs.zellij.enable = true;
    programs.zoxide.enable = true;
  };
}
