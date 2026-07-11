{ self, inputs, ... }: {
  flake.nixosModules.revolve = { pkgs, ... }: {
    users.users.revolve = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
