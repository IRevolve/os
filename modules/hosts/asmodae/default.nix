{ self, inputs, ... }: {
  flake.nixosConfigurations.asmodae = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
    };

    modules = [
      # Hardware Configuration
      self.nixosModules.asmodaeHardware
      
      # Shared Modules
      self.nixosModules.boot
      self.nixosModules.network
      self.nixosModules.revolve
      self.nixosModules.locale
      self.nixosModules.settings
      self.nixosModules.shell
      
      # System Modules
      self.nixosModules.jellyfin
      self.nixosModules.samba
      self.nixosModules.immich
      self.nixosModules.vaultwarden
      self.nixosModules.homepage

      # ssh & co
      self.nixosModules.server
      self.nixosModules.routing

      {
        atreia = {
          boot.zenKernel.enable = false;
          boot.zfs.enable = true;
          network.hostName = "asmodae";
        };

        # DO NOT CHANGE
        system.stateVersion = "26.05";
      }
    ];
  };
}
