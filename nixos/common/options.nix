{ lib, ... }:

with lib;

{
  options = {
    machine.name = mkOption {
      type = types.string;
      description = ''The machine's hostname.'';
    };

    machine.hostId = mkOption {
      type = types.string;
      description = ''The value of "networking.hostId", necessary for ZFS.'';
    };

    machine.vboxHost = mkOption {
      type = types.bool;
      description = ''Whether to enable VirtualBox host tools.'';
    };

    machine.wifi = mkOption {
      type = types.bool;
      description = ''Whether to enable wireless networking.'';
    };

    machine.bluetooth = mkOption {
      type = types.bool;
      description = ''Whether to enable Bluetooth.'';
    };

    machine.cpu.cores = mkOption {
      type = types.int;
      description = ''Number of processor cores (specifically, max number of Nix jobs to run in parallel).'';
    };

    machine.cpu.intel = mkOption {
      type = types.bool;
      description = ''Whether the machine has an Intel CPU, and so should enable Intel microcode updates.'';
    };

    machine.fsdevices.root = mkOption {
      type = types.string;
      description = ''Device in /dev holding the root filesystem.'';
    };

    machine.fsdevices.efi = mkOption {
      type = types.string;
      description = ''Device in /dev holding the EFI system filesystem.'';
    };

    machine.fsdevices.grub = mkOption {
      type = types.string;
      description = ''Device in /dev holding the disk (not partition!) on which the GRUB bootloader is installed.'';
    };

    machine.fsdevices.swap = mkOption {
      type = types.string;
      description = ''Device in /dev holding the swap partition.'';
    };

    machine.i3blocks.cpuThermalZone = mkOption {
      type = types.string;
      example = "thermal_zone2";
      description = ''Subdirectory of /sys/class/thermal representing the CPU temperature sensor.'';
    };

    machine.i3blocks.ethInterface = mkOption {
      type = types.string;
      example = "enp4s0";
      description = ''Name of the Ethernet network interface.'';
    };

    machine.i3blocks.wlanInterface = mkOption {
      type = types.string;
      example = "wlp3s0";
      description = ''Name of the WiFi network interface.'';
    };
  };
}
