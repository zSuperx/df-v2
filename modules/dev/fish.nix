{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.fish;
in {
  options.custom.fish = mkEnableOption "fish";

  config = mkIf cfg.enable {
    fish = {
      enable = true;
      plugins = [
        {
          name = "tide";
          inherit (pkgs.fishPlugins.tide) src;
        }
      ];

      shellAliases = {
        # Remaps to modern versions
        ls = "eza";
        l = "eza -alh";
        grep = "rg --color";
        cat = "bat";

        # Useful shorthands
        wlc = "wl-copy";
        wlp = "wl-paste";
        gs = "git status";
        gc = "git commit -m";
        ga = "git add";
        ww = "wonderwall";
        nv = "nvim";

        clera = "clear"; # Yes, I'm that bad at typing

        # Actual shortcuts
        y = "cd $(yazi --cwd-file=/dev/stdout)";
      };

      # Disable Fish greeting & add ~/bin to path
      interactiveShellInit = ''
        set fish_greeting
        set PATH "$HOME/bin:$PATH"
        nitch
      '';
    };
  };
}
