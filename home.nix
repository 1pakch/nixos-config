{ pkgs, ... }:
{
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";

  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/private"; }
    ];
  };

  programs.home-manager.enable = true;

  # Don't change ever. This tells Home Manager what version your home directory
  # was set up with initially so it knows which state migrations to skip.
  # (similar to `system.stateVersion` in `configuration.nix`)
  home.stateVersion = "25.11";
}
