{ self, inputs, ... }: {
  flake.nixosConfigurations.asmodae = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = {
      inherit inputs;
    };

    modules = [
      self.nixosModules.asmodaeHardware
      self.nixosModules.asmodaeConfig
      self.nixosModules.settings

      {
        # DO NOT CHANGE
        system.stateVersion = "26.06";
      }
    ];
  };
}
