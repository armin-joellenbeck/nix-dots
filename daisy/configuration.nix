{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";

  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>

    ./graphics.nix
    ./sound.nix
    ./users.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  console.keyMap = "de-latin1-nodeadkeys";

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  #networking
  networking.hostName = "daisy";
  networking.networkmanager.enable = true;

  # location
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    micro
  ];
}
