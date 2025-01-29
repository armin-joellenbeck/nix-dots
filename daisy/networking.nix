{ config, pkgs, ... }:

{
  networking = {
    hostName = "daisy";
    networkmanager.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services.blueman.enable = true;
}
