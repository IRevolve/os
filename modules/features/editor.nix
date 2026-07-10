{ self, inputs, ... }: {
  flake.nixosModules.editor = { pkgs, home-manager, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    environment.systemPackages = [
      pkgs.ripgrep
      pkgs.fd
    ];
    
    home-manager.users.revolve = {
      xdg.configFile."nvim".source = ../../config/nvim;
    };
  };
}
