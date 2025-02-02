{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b3ae1797-4a8f-4886-88f5-fa68131f1e84";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/872B-A65B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/df92bee0-424f-475a-9159-e0d6266610b6";
    }
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
      modesetting.enable = false;
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
