{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.profiles.basic;
in {
  options.custom.profiles.basic = mkEnableOption "basicelopment profile";

  config = mkIf cfg.enable {
    custom = {
      discord.enable = true;
    };
  };
}
