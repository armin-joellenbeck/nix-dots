{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      autoLogin = {
        enable = false;
        user = "armin";
      };
    };

    xserver = {
      enable = true;

      displayManager.lightdm.enable = true;

      desktopManager.xfce = {
        enable = true;
        enableScreensaver = false;
      };
    };
  };
}
