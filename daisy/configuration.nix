{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";

  imports = [
    ./graphics.nix
    ./hardware.nix
    ./location.nix
    ./networking.nix
    ./packages.nix
    ./sound.nix
    ./users.nix
  ];
}
