{ config, pkgs, lib, ... }:

{
  users.users.armin = {
    isNormalUser = true;
    description = "Armin Jöllenbeck";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEl8jkdkQeJjQnHXlG+SwFLgFNdtGb81aE+BUTI7Eu+g JuiceSSH"
    ];
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
