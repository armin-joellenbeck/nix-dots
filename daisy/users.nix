{ config, pkgs, lib, ... }:

{
  users.users.armin = {
    isNormalUser = true;
    description = "Armin Jöllenbeck";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  imports = [
    <home-manager/nixos>
  ];

  home-manager = {
    useGlobalPkgs = true;

    backupFileExtension = "backup";

    users.armin = { pkgs, ... }: {
      imports = [
        ../armin/home.nix
      ];
    };    
  };

}
