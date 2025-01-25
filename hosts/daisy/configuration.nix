{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  system.stateVersion = "24.11";

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  console.keyMap = "de-latin1-nodeadkeys";

  #networking
  networking.hostName = "daisy";
  networking.networkmanager.enable = true;

  # location
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # graphics
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

  # sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    micro
  ];

  # users/defaults
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
  };


  # users/armin
  users.users.armin = {
    isNormalUser = true;
    description = "Armin Jöllenbeck";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.armin = { pkgs, ... }: {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      google-chrome
    ];

    programs.bash = {
      enable = true;

      shellAliases = {
        ll = "ls -al";
        ls = "ls --color=auto --group-directories-first -v";
      };
    };

    programs.micro = {
        enable = true;

        settings = {
          autosu = true;

          colorscheme = "twilight";

          colorcolumn = 81;

          hlsearch = true;

          helpsplit = "vsplit";

          hltaberrors = true;

          rmtrailingws = true;

          smartpaste = true;
          tabsize = 2;
          tabstospaces = true;
        };
    };

    programs.gh = {
      enable = true;

      gitCredentialHelper.enable = true;
    };

    programs.git = {
      enable = true;

      extraConfig = {
        advice = {
          skippedCherryPicks = false;
        };

        core = {
          editor = "micro";
        };

        fetch = {
          prune = true;
          pruneTags = true;
        };

        init = {
          defaultBranch = "main";
        };

        push = {
          autoSetupRemote = true;
        };

        user = {
          name = "Armin Jöllenbeck";
          email = "armin@joellenbeck.net";
        };
      };
    };
  };
}
