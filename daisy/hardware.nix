{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"
      ];

      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;

      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  console.keyMap = "de-latin1-nodeadkeys";

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;

    graphics = {
      enable = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      modesetting.enable = true;
    };
  };

  services.xserver = {
    xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };

    videoDrivers = ["nvidia"];
  };
}
