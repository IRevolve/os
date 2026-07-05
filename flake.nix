{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.sanctum = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager

	{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	}

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
