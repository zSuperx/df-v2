{
  self,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf listOf submodule str deferredModule;
  cfg = config.systemConfigs;
in {
  options.systemConfigs = mkOption {
    default = {};
    description = "System!";
    type = attrsOf (submodule {
      options = {
        username = mkOption {
          description = "Username of machine";
          type = str;
        };

        profile = mkOption {
          description = "list of profiles to enable.";
          type = listOf str;
        };

        extraModules = mkOption {
          default = [];
          type = listOf deferredModule;
        };

        extraConfig = mkOption {
          default = {};
          type = deferredModule;
        };
      };
    });
  };

  config.flake.nixosConfigurations =
    builtins.mapAttrs (
      name: value: let
        inherit (cfg.${name}) host username profiles extraModules extraConfig;
      in
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs username;};

          modules =
            [
              inputs.home-manager.nixosModules.home-manager
              {
                networking.hostName = host;

                # set user
                users.users.${username} = {
                  isNormalUser = true;
                  extraGroups = [
                    "networkmanager"
                    "wheel"
                    "docker"
                  ];
                };

                # home-manager basic setup
                home-manager = {
                  users.${username} = {
                    home.stateVersion = "25.11";
                    programs.home-manager.enable = true;
                  };
                  useGlobalPkgs = true;
                  useUserPkgs = true;
                  extraSpecialArgs = {inherit inputs username;};
                };
              }

              # enable all included profiles
              builtins.listToAttrs
              (map (profileName: {
                  name = "custom.profiles.${profileName}.enable";
                  value = true;
                })
                profiles)

              extraConfig
            ]
            ++ extraModules
            ++ (inputs.import-tree "${self}/modules");
        }
    )
    cfg;
}
