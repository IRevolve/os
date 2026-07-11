{ self, inputs, ... }: {
  flake.nixosModules.server = { pkgs, ... }: {
    users.users = {
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAd7kjEdXf/tomwYJcMIrtyP3qI8w1OyfaDtGZ+mg1aD revolve@atreia.io"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      neovim
      git
    ];

    services.openssh.enable = true;

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

