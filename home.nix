{ pkgs, ... }:
{
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";

  home.shellAliases = {
    ll = "ls -la";
    lh = "ls -lh";
    dr = "direnv reload";
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
  };

  programs.bash.enable = true; # otherwise aliases are not picked up

  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/private"; }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      vscodevim.vim
    ];
  };

  programs.home-manager.enable = true;

  # Don't change ever. This tells Home Manager what version your home directory
  # was set up with initially so it knows which state migrations to skip.
  # (similar to `system.stateVersion` in `configuration.nix`)
  home.stateVersion = "25.11";
}
