{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = "armin";
      };
    };

    xserver = {
      enable = true;

      displayManager.lightdm.enable = true;

      desktopManager.xfce.enable = true;

      xkb = {
        layout = "de";
        variant = "nodeadkeys";
      };
    };
  };


  # nvidia

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

      modesetting.enable = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

}


