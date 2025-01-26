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

  # nvidia

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {

    # Modesetting is required.
    # TODO: Default is false
    # modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    # TODO: Default is false
    #powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    # TODO: Default is false
    # powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    # TODO: Default is false or null
    # open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    # TODO: Default is true
    # nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.

    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}
