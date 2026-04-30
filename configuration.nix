{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # hostname
  networking.hostName = "tat";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Allow nix flakes and non-free sofware
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  fonts.packages = with pkgs; [
    iosevka
  ];

  # Enable the X11 windowing system.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Uncomment to swap the Caps Lock and Esc keys
  # services.xserver.xkb.options = "caps:swapescape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound (well it works already in GNOME)
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # User accounts
  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
    initialPassword = "changeme";
    packages = with pkgs; [
      neovim
      tree
      ripgrep
      tmux
      alacritty
      jq
      git
      gh
      claude-code
      wl-clipboard
      direnv
      nix-direnv
      nixfmt
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used for compatibility with application data (e.g. databases) created on older NixOSes.
  # Most users should NEVER change this value after the initial install, for any reason.
  system.stateVersion = "25.11"; # Did you read the comment?

  # Enabled by GNOME by default but tlp is better for thinkpads
  services.power-profiles-daemon.enable = false;

  # Smarter power management for thinkpads
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Suspend on lid close
  services.logind.settings.Login.HandleLidSwitch = "suspend";

}
