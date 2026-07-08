{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, inputs, ... }: {
    imports = [
      inputs.qylock.nixosModules.default
    ];


    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs.qylock = {
      enable = true;
      theme = "nier-automata";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.xwayland-satellite
    ];

  };
}
