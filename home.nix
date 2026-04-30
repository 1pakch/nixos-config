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

  programs.bash.enable = true; # otherwise aliases are not picked up
  programs.home-manager.enable = true;

  # Don't change ever. This tells Home Manager what version your home directory
  # was set up with initially so it knows which state migrations to skip.
  # (similar to `system.stateVersion` in `configuration.nix`)
  home.stateVersion = "25.11";
}
