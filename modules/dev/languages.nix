{
  config,
  lib,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.languages;
in {
  options.custom.languages = mkEnableOption "languages";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      # Language utilities
      # All LSPs are provided by NVF since they are only used in IDE environments
      home = {pkgs, ...}: {
        home.packages = with pkgs; [
          # C
          libclang
          gcc
          gnumake
          valgrind
          gdb

          # RUST
          (fenix.complete.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ])

          # Python
          python312
        ];
      };
    };
  };
}
