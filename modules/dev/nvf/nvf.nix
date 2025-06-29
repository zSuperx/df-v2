{
  flake.nixosModules.nvf = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.custom.nvf;
  in {
    options.custom.nvf = mkEnableOption "nvf";

    config = mkIf cfg.enable {
      programs.nvf = {
        enable = true;
        settings = import ./_nvim-settings.nix;
      };

      stylix.targets.nvf.enable = true;
    };
  };
}
