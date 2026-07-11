{ self, inputs, ... }: {
  flake.nixosModules.server = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      git
    ];
  };
}

