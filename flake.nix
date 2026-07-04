{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.sanctum = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # DO NOT MODIFY
        { system.stateVersion = "26.05"; }

	./hardware-configuration.nix
	./modules/boot.nix
	./modules/gpu.nix
	./modules/locale.nix
	./modules/desktop.nix
	./modules/packages.nix
	./modules/network.nix
	./modules/audio.nix
	./modules/settings.nix
	./modules/user.nix
	./modules/bluetooth.nix
      ];
    };
  };
}
