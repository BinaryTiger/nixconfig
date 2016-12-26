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
  environment.systemPackages = with pkgs; [
    arc-gtk-theme
    ctags
    inotify-tools
    git
    google-chrome
    i3status
    neovim
    nodejs
    mc
    imagemagick
    python3
    python35Packages.neovim
    (import ./vim.nix)
    python35Packages.pip
    cmake
    rofi
    screenfetch #add support for neofetch in nixpks repo
    scrot
    taskwarrior
    vimPlugins.YouCompleteMe
    terminator
    tree
    vim
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

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.enable = true;
  services.xserver.windowManager.i3.enable = true;

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
