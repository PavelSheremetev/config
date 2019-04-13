self: super: {
  admesh = super.callPackage ./admesh { };
  archiveman = super.callPackage ./archiveman { };
  boincgpuctl = super.callPackage ./boincgpuctl { };
  boincmgr = super.callPackage ./boincmgr { inherit (self.xorg) xauth; };
  circleci = super.callPackage ./circleci { };
  freesweep = super.callPackage_i686 ./freesweep { };
  ftb-launcher = super.callPackage ./ftb-launcher { };
  gds2svg = super.callPackage ./gds2svg { };
  hartmaster = super.callPackage ./hartmaster { };
  home-manager = super.callPackage ./home-manager { };
  i3blocks-scripts = super.callPackage ./i3blocks-scripts { inherit (self.linuxPackages) nvidia_x11; };
  libkoki = super.callPackage ./libkoki { };
  lock = super.callPackage ./lock { };
  magic = super.callPackage ./magic { };
  mountext = super.callPackage ./mountext { };
  mstream = super.callPackage ./mstream { nodejs = self."nodejs-6_x"; };
  passchars = super.callPackage ./passchars { pythonPackages = self.python27Packages; };
  pcb-rnd = super.callPackage ./pcb-rnd { };
  pysolfc = super.callPackage ./pysolfc { };
  publish = super.callPackage ./publish { };
  quartus = super.callPackage ./quartus { };
  redstore = super.callPackage ./redstore { };
  repetier-host = super.callPackage ./repetier-host { };
  riscv-gnu-toolchain = super.callPackage ./riscv-gnu-toolchain/default.nix { };
  screenshot = super.callPackage ./screenshot { inherit (self.gnome3) eog; };
  soton-mount = super.callPackage ./soton-mount { };
  soton-rdp = super.callPackage ./soton-rdp { };
  soton-umount = super.callPackage ./soton-umount { };
  umountext = super.callPackage ./umountext { };
}
