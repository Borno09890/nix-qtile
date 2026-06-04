{
  config,
  pkgs,
  ...
}: {
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "com.github.tchx84.Flatseal"
  ];

  services.flatpak.overrides = {
    "org.vinegarhq.Sober" = {
      Context.sockets = ["wayland" "!x11"];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = ["gtk"];
  };
}
