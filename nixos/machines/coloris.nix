{ config, lib, pkgs, ... }:

let
  localPkgs = import ../../pkgs pkgs;

  samba = import ../samba.nix;
  sambaClient = samba.client {
    host = "soton";
    port = 9092;
  };
in

{
  imports = [
    ../common
    ../extras/boot-efi.nix
    ../extras/boinc.nix
    ../extras/desktop
    sambaClient
  ];

  machine = {
    name = "coloris";
    hostId = "db4d501a";
    vboxHost = true;
    wifi = true;
    bluetooth = true;

    cpu = {
      cores = 4;
      intel = true;
    };

    fsdevices = {
      root = "/dev/disk/by-uuid/059315e0-e130-475c-9d84-45e4ef750a6b";
      efi = "/dev/disk/by-uuid/6F09-65AE";
      swap = "/dev/disk/by-uuid/afd2e652-b34e-4543-95c3-e2fc5df22201";
    };

    i3blocks = {
      cpuThermalZone = "thermal_zone2";
      ethInterface = "enp4s0";
      wlanInterface = "wlp3s0";
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbcore" "sd_mod" "sr_mod" ];
  powerManagement.cpuFreqGovernor = "powersave";

  hardware.ckb.enable = true;
  hardware.ckb.package = pkgs.libsForQt5.callPackage ../lib/ckb-next.nix {};

  services.xserver.xrandrHeads = ["HDMI-0" "DP-0"];

  # Additional filesystems (LVM).
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7ea83533-f78b-4deb-94ed-6bef5dbfa8e4";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/c522b9a8-b534-428c-9e4e-6d297ed9dba4";
    fsType = "ext4";
  };

  environment.systemPackages = [
    localPkgs.boincgpuctl
    localPkgs.google-musicmanager
    localPkgs.keybase
  ];
}
