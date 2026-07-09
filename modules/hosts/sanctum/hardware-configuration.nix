{ self, inputs, ... }: {
  flake.nixosModules.sanctumHardware = { config, lib, modulesPath, ... }: {
    imports = [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = { 
      device = "/dev/disk/by-uuid/b38585ea-2488-44fb-8bdc-6d056f6e900a";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/b38585ea-2488-44fb-8bdc-6d056f6e900a";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    fileSystems."/nix" = { 
      device = "/dev/disk/by-uuid/b38585ea-2488-44fb-8bdc-6d056f6e900a";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-uuid/b38585ea-2488-44fb-8bdc-6d056f6e900a";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/8880-B501";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
