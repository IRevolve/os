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
      
      # Features
      self.nixosModules.ssh
      self.nixosModules.podman
      self.nixosModules.tunnel
      self.nixosModules.database
      self.nixosModules.samba
      
      # Services
      self.nixosModules.homepage
      self.nixosModules.nextcloud
      self.nixosModules.vaultwarden
      self.nixosModules.jellyfin
      self.nixosModules.immich
 
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
