{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.profiles.dev;
in {
  options.custom.profiles.dev = mkEnableOption "development profile";

  config = mkIf cfg.enable {
    custom = {
      languages.enable = true;
      shell-tools.enable = true;
      nvf.enable = true;
    };
  };
}
