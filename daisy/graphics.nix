{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      autoLogin = {
        enable = true;
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
