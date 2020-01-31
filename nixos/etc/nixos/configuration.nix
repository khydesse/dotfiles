# /$$   /$$ /$$$$$$ /$$   /$$  /$$$$$$   /$$$$$$           
#| $$$ | $$|_  $$_/| $$  / $$ /$$__  $$ /$$__  $$          
#| $$$$| $$  | $$  |  $$/ $$/| $$  \ $$| $$  \__/          
#| $$ $$ $$  | $$   \  $$$$/ | $$  | $$|  $$$$$$           
#| $$  $$$$  | $$    >$$  $$ | $$  | $$ \____  $$          
#| $$\  $$$  | $$   /$$/\  $$| $$  | $$ /$$  \ $$          
#| $$ \  $$ /$$$$$$| $$  \ $$|  $$$$$$/|  $$$$$$/          
#|__/  \__/|______/|__/  |__/ \______/  \______/           
#                                                                                                                    
#                                                          
#  /$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$$$ /$$$$$$  /$$$$$$ 
# /$$__  $$ /$$__  $$| $$$ | $$| $$_____/|_  $$_/ /$$__  $$
#| $$  \__/| $$  \ $$| $$$$| $$| $$        | $$  | $$  \__/
#| $$      | $$  | $$| $$ $$ $$| $$$$$     | $$  | $$ /$$$$
#| $$      | $$  | $$| $$  $$$$| $$__/     | $$  | $$|_  $$
#| $$    $$| $$  | $$| $$\  $$$| $$        | $$  | $$  \ $$
#|  $$$$$$/|  $$$$$$/| $$ \  $$| $$       /$$$$$$|  $$$$$$/
# \______/  \______/ |__/  \__/|__/      |______/ \______/ 

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Include the results of the hardware scan.
    ];

  system.stateVersion = "19.03"; # NixOS version, Do not change unless release notes state so.
  boot.loader.grub.enable = true; # Use the GRUB 2 boot loader.
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # Define on which hard drive you want to install Grub.
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use the latest kernel.
  boot.loader.grub.useOSProber = true;
  time.timeZone = "Africa/Cairo"; # Set your time zone.

  networking.hostName = "X230"; # Define your hostname.
  networking.networkmanager.enable = true; # Enables networking support via network manager.
  nixpkgs.config.allowBroken = true; 
  nixpkgs.config.allowUnfree = true; # Enables non-free software.
  environment.systemPackages = with pkgs; [
     stow
     git
     aria2
     neovim
     rxvt_unicode
     mpv
     feh
     qutebrowser
     ntfs3g
     android-file-transfer
     steam-run
     tdesktop
  ];
  # Services enabled.
  services.xserver.enable = true; # Enable the X11 windowing system.
  services.xserver.layout = "us"; # Not really sure what that does tbh.
  services.xserver.windowManager.i3.enable = true; # Enable i3wm.
  services.xserver.displayManager.startx.enable = true; # Enable startx.
  services.xserver.desktopManager.xterm.enable = false; # Disable xterm.
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.libinput.enable = true; # Enable touchpad support.
  services.tlp.enable = true; # Enable battery saving via TLP.
  services.openssh.enable = true; # Enable SSH.
  services.openssh.passwordAuthentication = false; # Disable ssh password login.  
  services.xserver.xkbOptions = "Escape:swapcaps";
  programs.tmux.enable = true;
  programs.adb.enable = true;
  programs.light.enable = true;
  nix.autoOptimiseStore = true;
  # Other options.
  programs.java.enable = true;
  virtualisation.docker.enable = true;
  sound.enable = true;  # Enable sound.
  hardware.pulseaudio.enable = true; # Enable PulseAudio.
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl intel-media-driver ];
  i18n.consoleUseXkbConfig = true; 

  # User account.
  users.users.nihad = {
     isNormalUser = true;
     extraGroups = [ "wheel" "sudo" "audio" "video" "adbusers" "docker" "nixos" ]; 
     shell = pkgs.bash;
   };

  
}
