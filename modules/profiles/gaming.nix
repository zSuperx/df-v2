{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.profiles.gaming;
in {
  options.custom.profiles.gaming = mkEnableOption "gaming profile";

  config = mkIf cfg.enable {
    custom = {
    };
  };
}
