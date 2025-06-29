{self, inputs, lib, ... }: {

  flake.lib.mkSystem = {
    username,
    host,
    profiles ? [],
    modules ? [],
    extraConfig ? {},
  }:
    lib.nixosSystem {
      modules = [
        # Default nixos module for configuration + hardware-configuration.nix
        "${self}/hosts/${host}"
        inputs.home-manager.nixosModules.home-manager

        builtins.listToAttrs
        (map (profileName: {
            name = "${profileName}.enable";
            value = true;
          })
          profiles)

        {
          # Set networking hostname
          networking.hostName = host;

          imports = modules ++ profiles;

          # Set the user
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

        extraConfig
      ];
      specialArgs = {inherit inputs username;};
    };
}
