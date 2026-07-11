{ self, inputs, ... }: {
  flake.nixosModules.podman = { ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    }; 
  };
}
