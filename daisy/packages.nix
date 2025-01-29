{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  environment.systemPackages = with pkgs; [
    micro
  ];
}
