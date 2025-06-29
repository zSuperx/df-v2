{
  config,
  lib,
  inputs,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.hyprland;
in {
  options.custom.hyprland.enable = mkEnableOption "hyprland";

  config = mkIf cfg.enable {
    programs.hyprland = let
      system = pkgs.stdenv.hostPlatform.system;
    in {
      enable = true;

      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    home-manager.users.${username}.home.file.".config/hypr".source =
      lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/df-v2/symlinks/hypr";
  };
}
