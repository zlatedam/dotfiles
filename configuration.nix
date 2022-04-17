{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
   time.timeZone = "Australia/Sydney";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # xmonad + lightdm setup
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable =true;
  services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.windowManager = {
     xmonad.enable = true;
     xmonad.enableContribAndExtras = true;
     xmonad.extraPackages = hpkgs: [
       hpkgs.xmonad
       hpkgs.xmonad-contrib
       hpkgs.xmonad-extras
];
};

  # Configure keymap in X11
    services.xserver.layout = "us";
    services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound & bluetooth support
  # Pulseaudio settings  
    # sound.enable = true;
    hardware.pulseaudio.enable = false;     
hardware.bluetooth.enable = true;
     services.blueman.enable = true;

 # Pipewire setup
    security.rtkit.enable = true;
    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.zlatko = {
     isNormalUser = true;
     initialPassword = "helloworld";
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

   environment.systemPackages = with pkgs; [
   # Terminal & config
   vim
   htop
   git
   feh
   ranger
   neofetch
   openssl
   openssl.dev
   tmux
   mupdf 
    
   #GUI Applications 
   wget
   firefox
   discord
   spotify
   mpv
   steam
   lutris
   spotify
   soulseekqt
   deluge
   libreoffice
      
   # Game specific drivers / packages
   vulkan-tools
 
   # Dev Environment 
   jre
   vscodium
   adoptopenjdk-icedtea-web
 
   # xmonad applications 
   xmobar
   nitrogen
   picom
   dmenu
   ];

  # SUID Wrapper
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:
 
  # Steam install 
     programs.steam.enable = true; 

  # Official NVIDIA Drivers 
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true; 

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Flathub 
  services.flatpak.enable = true;

  # Steam missing dependencies 
  nixpkgs.config.packageOverrides = pkgs: {
  steam = pkgs.steam.override {
  extraPkgs = pkgs: with pkgs; [
  libgdiplus
  ];
  };
};

  system.stateVersion = "21.11"; # Did you read the comment?

}

