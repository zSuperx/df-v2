{
  config,
  lib,
  inputs,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.hypr-utils;
in {
  options.custom.hypr-utils.enable = mkEnableOption "hyprland utils";

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.hyprpanel.overlay
    ];

    home-manager.users.${username} = {
      imports = [
        inputs.hyprpanel.homeManagerModules.hyprpanel
      ];

      home.packages = with pkgs; [
        hyprpaper
        hypridle
        hyprshot
        hyprlock
      ];

      hyprpanel = {
        enable = true;
        hyprland.enable = true;
        overwrite.enable = true;

        override = {
          menus.dashboard.powermenu.avatar.image = "~/.face.icon";
          theme = {
            bar.buttons.dashboard.icon = "#81A1CA";
            bar.buttons.style = "wave";
            font.size = "0.9rem";
          };
        };

        settings = {
          bar = {
            launcher.icon = "";
            workspaces = {
              showApplicationIcons = true;
              showWsIcons = true;
              numbered_active_indicator = "highlight";
            };
            notifications.show_total = true;
            media.rightClick = "playerctl --player=spotify metadata xesam:url | wl-copy";
          };

          notifications.ignore = ["spotify"];

          scalingPriority = "hyprland";
        };
      };
    };
  };
}
