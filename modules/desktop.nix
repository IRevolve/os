{ inputs, pkgs, ... }: {
  
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
