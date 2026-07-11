{ self, inputs, ... }: {
  flake.nixosModules.packages = { pkgs, lib, home-manager, ... }: {
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

      steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };

    environment.systemPackages = [
      pkgs.kitty
      pkgs.tree
      pkgs.pcsx2
      pkgs.faugus-launcher
      pkgs.wowup-cf

      (pkgs.discord.override {
        withOpenASAR = true;
      })
    ];
  };
}
