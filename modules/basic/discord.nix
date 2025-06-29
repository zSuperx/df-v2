{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.discord;
in {
  options.custom.discord.enable = mkEnableOption "discord";

  config = mkIf cfg.enable {
    stylix.targets.vesktop.enable = false;

    programs.vesktop = {
      enable = true;
      settings.enabledThemes = ["system24.theme.css"];
      vencord.themes = {
        system24 = ./system24.theme.css;
      };
    };
  };
}
