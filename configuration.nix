{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./flatpak.nix
  ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Dhaka";

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
  services.displayManager = {
    ly.enable = true;
    defaultSession = "none+i3";
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.flatpak.enable = true;

  users.users.nix = {
    isNormalUser = true;
    extraGroups = ["wheel" "video"];
    packages = with pkgs; [
      zed-editor
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "26.05";
}
