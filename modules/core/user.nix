{ self, inputs, ... }: {
  flake.nixosModules.user = { pkgs, ... }: {
    users.users = {
      revolve = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };
}
