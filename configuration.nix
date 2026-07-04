{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
  };

  networking.hostName = "sanctum"; 

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  console.keyMap = "de-latin1-nodeadkeys";

  services.xserver.xkb.layout = "de";
  services.xserver.xkb.variant = "nodeadkeys";

  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  users.users.revolve = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    ripgrep
    kitty
  ];

  system.stateVersion = "26.05"; 

}

