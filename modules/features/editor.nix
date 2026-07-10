{ self, inputs, ... }: {
  flake.nixosModules.editor = { pkgs, home-manager, ... }: {
    home-manager.users.revolve = {
      programs.neovim = {
        enable = true;
        defaultEditor = true;

        extraPackages = [
          pkgs.ripgrep
          pkgs.fd
        ];
      };

      xdg.configFile."nvim".source = ../../config/nvim;
    };
  };
}
