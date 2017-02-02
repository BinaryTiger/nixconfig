# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  swapDevices = [ { device = "/dev/sda5"; } ];
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.variables = {

  };
  environment.systemPackages = with pkgs; [
    (import ./vim.nix)
    cargo
    clang
    nix-prefetch-git
    cmake
    ctags
    elixir
    erlang
    gcc
    gimp
    git
    gnumake
    google-chrome
    i3status
    imagemagick
    inotify-tools
    jekyll
    mc
    nodejs
    pavucontrol
    python3
    python35Packages.neovim
    python35Packages.pip
    rofi
    rustc
    screenfetch #add support for neofetch in nixpks repo
    scrot
    taskwarrior
    terminator
    tree
    unzip
    vim
    vimPlugins.YouCompleteMe
    vimPlugins.pluginnames2nix
    vlc
    wget
    xorg.xbacklight
    zsh
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
	inconsolata
	ubuntu_font_family
	unifont
	source-code-pro
    ];
  };

  # List services that you want to enable:
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql;
  services.postgresql.authentication = "local all all ident";

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Transform this into a nix module for easy reuse
  systemd.services.gitwatchDotFiles = {
    description = "Git watcher for dotfiles";
    wantedBy = [ "multi-user.target" ]; 
    after = [ "multi-user.target" ];
    environment = {
      GW_GIT_BIN = pkgs.git + "/bin/git";
      GW_INW_BIN = pkgs.inotify-tools + "/bin/inotifywait";
    };
    serviceConfig = {
      Type = "simple";
      User = "binarytiger";
      ExecStart = "/home/binarytiger/gitwatch.sh -r origin -b master /home/binarytiger";
      Restart = "always";
    };
  };

  virtualisation = {
    virtualbox.host.enable = true;
  };


  # Hardware
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.binarytiger = {
    isNormalUser = true;
    home = "/home/binarytiger";
    createHome = true;
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
