{ config, pkgs, ... }:

{
  users.users.armin = {
    isNormalUser = true;
    description = "Armin Jöllenbeck";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;

    backupFileExtension = "backup";

    users.armin = { pkgs, ... }: {
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        ghostty
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
  };

}
