{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.shell-tools;
in {
  options.custom.shell-tools = mkEnableOption "shell tools";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {pkgs, ...}: {
      home.packages = with pkgs; [
        fishPlugins.tide
        nerd-fonts.jetbrains-mono

        nitch
        eza
        rg
        bat
        dust
      ];

      programs = {
        zoxide = {
          enable = true;
          enableFishIntegration = true;
          options = ["--cmd cd"];
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
