{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";

  imports = [
    ./boot.nix
    ./graphics.nix
    ./location.nix
    ./networking.nix
    ./packages.nix
    ./sound.nix
    ./users.nix
  ];
}
