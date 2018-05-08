# Gyroscope is a Raspberry Pi hosting network shares and other services.
# It is named after the album "Gyroscope" by "Boards of Canada".

let
  nfsServer = { config, lib, pkgs, ... }: {
    services.nfs.server = {
      enable = true;
      createMountPoints = true;
      exports = ''
        /net/gyroscope/torrents 10.99.0.0/16(ro,all_squash,anonuid=70,anongid=70) # UID and GID for 'transmission'
      '';
    };
    networking.firewall.allowedTCPPorts = [ 2049 ];
  };

  transmissionClient = { config, lib, pkgs, ... }: {
    services.transmission = {
      enable = true;
      port = 9091; # web interface
      settings = import ../transmission-settings.nix // {
        download-dir = "/net/gyroscope/torrents";
      };
    };
    users.users.kier.extraGroups = [ "transmission" ];
    networking.firewall.allowedTCPPorts = [ 9091 51413 ];
    networking.firewall.allowedUDPPorts = [ 6771 51413 ];
  };
in

{ config, lib, pkgs, ... }:
{
  imports = [
    ../common
    ../extras/platform/raspberry-pi-3.nix
    ../extras/headless.nix
    nfsServer
    transmissionClient
  ];

  machine = {
    name = "gyroscope";
    wifi = false;

    cpu = {
      cores = 4;
    };

    fsdevices = {
      boot = "/dev/disk/by-label/boot0";
      root = "/dev/disk/by-label/root0";
      swap = "/dev/disk/by-label/swap0";
      tmp = "/dev/disk/by-label/tmp0";
    };
  };

  networking.hostId = "abee6add";

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  powerManagement.cpuFreqGovernor = "ondemand";

  campanella-vpn.client = {
    enable = true;
    certFile = ../../secret/vpn/certs/gyroscope.crt;
    keyFile = "/etc/gyroscope.key";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home0";
    fsType = "ext4";
  };
  fileSystems."/net/gyroscope/torrents" = {
    device = "/dev/disk/by-label/torrents0";
    fsType = "ext4";
  };

  boot.initrd.preLVMCommands = ''
    echo "Sleeping for a few seconds to wait for the hard disk to spin up..."
    sleep 4
  '';
}
