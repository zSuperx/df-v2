{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.wayland-utils;
in {
  options.custom.wayland-utils.enable = mkEnableOption "wayland-utils";

  config = mkIf cfg.enable {
    custom.wofi.enable = true;

    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      enable = true;
      autoEnable = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      opacity.terminal = 0.9;
      fonts.sizes.terminal = 11;
      fonts.monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      polarity = "dark";
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wf-recorder
      socat
      swaynotificationcenter
      brightnessctl
      networkmanagerapplet
      playerctl
      pavucontrol
    ];
  };
}
