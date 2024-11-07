{ user, sudo, ... }:
let
  fallbackPath = ".nix-fallback/desktop/programs/shells/aliases/kubectl";
  sourcePath = "~${user}/nix/desktop/programs/shells/aliases/kubectl";
  targetPath = "~${user}/.config/fish";
  mkSymlink = filename: ''
    ${sudo} -u ${user} ln -sf ${sourcePath}/${filename} ${targetPath}/${filename}
  '';
in
{
  system.activationScripts = {
    postUserActivation = {
      text = ''
        ${sudo} -u ${user} mkdir -p ${targetPath}
        ${mkSymlink "kubectl_aliases.fish"}
      '';
    };
  };

  home-manager.users.${user} = {
    home.file = {
      "${fallbackPath}/kubectl_aliases.fish" = {
        source = ./kubectl_aliases.fish;
      };
    };

    programs.fish = {
      interactiveShellInit = ''
        if test -f ${targetPath}/kubectl_aliases.fish
          source ${targetPath}/kubectl_aliases.fish
        else
          source ~${user}/${fallbackPath}/kubectl_aliases.fish
        end
      '';
    };
  };
}
