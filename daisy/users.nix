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
      home.stateVersion = "24.11";

      xsession.windowManager.i3 = {
        enable = true;

        package = pkgs.i3-gaps;

        config = {
          modifier = "Mod4";

          gaps = {
            inner = 10;
            outer = 5;
          };

          terminal = "ghostty";

          startup = [
            { command = "google-chrome-stable"; }
            { command = "xsetroot -solid \"#555555\""; }
          ];

          bars = [
            {
              fonts = {
                names = ["pango"];
                style = "monospace";
                size = 16.0;
              };

              statusCommand = "i3status";
            }
          ];

          modes = {
            "[e]xit, [s]uspend, [r]eboot, [p]oweroff" = {
              "e" = "exec i3-msg exit";
              "s" = "exec systemctl suspend";
              "r" = "exec systemctl reboot";
              "p" = "exec systemctl poweroff";
              "Escape" = "mode \"default\"";
            };
          };

          keybindings = lib.mkOptionDefault {
            "Ctrl+Mod1+Delete" =
              "mode \"[e]xit, [s]uspend, [r]eboot, [p]oweroff\"";
          };
        };
      };

      programs.i3status = {
        enable = true;

        enableDefault = false;

        modules = {
          "tztime local" = {
            enable = true;

            settings = {
              format = "%H:%M";
            };
          };
        };
      };

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

            colorcolumn = 72;

            hlsearch = true;

            helpsplit = "vsplit";

            hltaberrors = true;

            rmtrailingws = true;

            savecursor = true;

            scrollbar = true;

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
