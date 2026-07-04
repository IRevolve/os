{ config, lib, pkgs, ... }:

{
  imports = [ 
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
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console.keyMap = "de-latin1-nodeadkeys";

  services.xserver.xkb.layout = "de";
  services.xserver.xkb.variant = "nodeadkeys";

  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.users.revolve = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ]; 
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    policies.DisableTelemetry = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {};

    shellInit = "fastfetch";
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "Revolve";
      user.email = "revolve@atreia.io";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.steam = {
    enable = true;

    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.starship = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    ripgrep
    kitty
    fastfetch
    lutris
  ];

  system.stateVersion = "26.05"; 

}

