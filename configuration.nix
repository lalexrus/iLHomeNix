# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "iLHomeNix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "ru_RU.UTF-8";
   console = {
    earlySetup = true;
    font = "ter-v16n";
    packages = [
      pkgs.terminus_font ];
    useXkbConfig = true;
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.displayManager.sddm.enable = true;
   services.desktopManager.plasma6.enable = true;
   services.displayManager.defaultSession = "plasma";
   services.displayManager.sddm.wayland.enable = true;

  

  # Configure keymap in X11
   services.xserver.xkb.layout = "us,ru";
   services.xserver.xkb.options = "grp:alt_shift_toggle";
   fonts.fontDir.enable = true;
   fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      nerdfonts
      stix-two
      twemoji-color-font
     ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.lalexrus = {
     isNormalUser = true;
     extraGroups = [ "qemu-libvirtd" "libvirtd" "video" "audio" "networkmanager" "disk" "wheel" ]; # Enable ‘sudo’ for the user.
     initialPassword = "0";
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
    };
  # Virtualization
   virtualisation.libvirtd.enable = true;
   programs.virt-manager.enable = true;
   boot.kernelModules = ["kvm-amd" "kvm-intel"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   services.flatpak.enable = true;
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     unzip
     mc
     bat
     duf
     remmina
     firefox
     speedcrunch
     curl
     openvpn
     keepassxc
     syncthing
     terminator
     variety
     htop
     vscode
     obsidian
     skypeforlinux
     fastfetch
     git
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.direnv.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
   services.blueman.enable = true;
   services = {
    syncthing = {
        enable = true;
        user = "lalexrus";
        dataDir = "/mnt/homes/lalexrus/.0.Sync";    # Default folder for new synced folders, instead of /var/lib/syncthing
        configDir = "/home/lalexrus/.config/syncthing";   # Folder for Syncthing's settings and keys. Will be overwritten by Nix!		
    };
   };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

