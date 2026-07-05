{ self, inputs, ... }: {
  flake.nixosModules.packages = { pkgs, lib, ... }: {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox-beta;
        policies.DisableTelemetry = true;
      };

      git = {
        enable = true;
        config = {
          user.name = "Revolve";
	  user.email = "revolve@atreia.io";
	  init.defaultBranch = "main";
	  pull.rebase = true;
        };
      };

      fish = {
        enable = true;
        shellAliases = {};
        shellInit = lib.getExe pkgs.fastfetch;
      };

      starship.enable = true;

      steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };

    environment.systemPackages = [
      pkgs.neovim
      pkgs.ripgrep
      pkgs.kitty
      pkgs.tree
      pkgs.xwayland-satellite
      pkgs.pcsx2
      pkgs.faugus-launcher
      pkgs.wowup-cf

      (pkgs.discord.override {
        withOpenASAR = true;
      })
    ];
  };
}
