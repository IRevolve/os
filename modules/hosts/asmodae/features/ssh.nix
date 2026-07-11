{ self, inputs, ... }: {
  flake.nixosModules.ssh = {
    services.openssh.enable = true;

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAd7kjEdXf/tomwYJcMIrtyP3qI8w1OyfaDtGZ+mg1aD revolve@atreia.io"
    ];
  };
}
