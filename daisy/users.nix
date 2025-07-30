{ config, pkgs, lib, ... }:

{
  users.users.armin = {
    isNormalUser = true;
    description = "Armin Jöllenbeck";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHlILC65uB97qxhZqACejWvnsEO6AlsZu89vm6VUYMH JuiceSSH"
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
