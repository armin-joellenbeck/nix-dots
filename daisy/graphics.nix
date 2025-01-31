{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      autoLogin = {
        enable = false;
        user = "armin";
      };

      defaultSession = "none+i3";
    };

    xserver = {
      enable = true;

      displayManager = {
        lightdm = {
          enable = true;
        };
      };

      windowManager.i3.enable = true;
    };
  };
}
