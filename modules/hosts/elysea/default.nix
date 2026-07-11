{ self, inputs, ... }: {
  flake.nixosConfigurations.elysea = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
    };

    modules = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.elyseaHardware
      self.nixosModules.boot
      self.nixosModules.bluetooth
      self.nixosModules.network
      self.nixosModules.desktop
      self.nixosModules.locale
      self.nixosModules.packages
      self.nixosModules.revolve
      self.nixosModules.gpu
      self.nixosModules.audio
      self.nixosModules.settings
      self.nixosModules.editor
      self.nixosModules.shell

      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.revolve.home.stateVersion = "26.05";

        atreia = {
          boot.zenKernel.enable = true;
          boot.zfs.enable = false;
          network.hostName = "elysea";
        };

        # DO NOT CHANGE
        system.stateVersion = "26.05";
      }
    ];
  };
}
