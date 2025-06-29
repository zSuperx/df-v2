{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.profiles.hyprland;
in {
  options.custom.profiles.hyprland = mkEnableOption "hyprland profile";

  config = mkIf cfg.enable {
    custom = {
      hyprland.enable = true;
      hypr-utils.enable = true;
      wayland-utils.enable = true;
    };
  };
}
