{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.kitty;
in {
  options.custom.kitty = mkEnableOption "kitty";

  config = mkIf cfg.enable {
    # Enable fish
    options.custom.fish.enable = true;

    kitty = {
      enable = true;
      settings = {
        shell = "fish";
        cursor_trail = "1";
      };
    };
  };
}
