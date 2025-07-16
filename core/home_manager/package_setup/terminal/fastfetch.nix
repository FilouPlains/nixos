{ config, lib, pkgs, osConfig, ... }:

let
  path = /etc/nixos/img;
  enable = !builtins.elem "fastfetch" osConfig.disabledPackage or true;
in
{
  config = lib.mkIf enable {
    xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON
      {
        logo = {
          source = "~/.config/fastfetch/logo_nix_white.png";
          type = "kitty";
          height = 6;
          width = 12;
          padding = {
            top = 1;
            left = 1;
          };
        };
        display = {
          separator = " ";
          constants = [
            "───────────────────────────────────────────────────────────────────────────"
            "\\u001b[90m│\\u001b[75C│\\u001b[75D"
            "\\u001b[90m"
          ];
          brightColor = false;
        };
        modules = [
          {
            format = "{$3}╭{$1}╮\\u001b[75D {#0} {user-name} 󰔂 {host-name}{$3} ";
            type = "title";
          }
          {
            key = "{$2}";
            type = "colors";
            symbol = "circle";
          }
          {
            key = "{$2}{#31} kernel   ";
            type = "kernel";
          }
          {
            key = "{$2}{#31}󱄅 distro   ";
            type = "os";
          }
          {
            key = "{$2}{#31}󰇄 desktop  ";
            type = "de";
          }
          {
            key = "{$2}{#32} term     ";
            type = "terminal";
          }
          {
            key = "{$2}{#32} shell    ";
            type = "shell";
          }
          {
            key = "{$2}{#33}󰍛 cpu      ";
            type = "cpu";
            showPeCoreCount = false;
            temp = false;
          }
          {
            key = "{$2}{#33}󰘚 gpu      ";
            type = "gpu";
          }
          {
            key = "{$2}{#35}󰉉 disk     ";
            type = "disk";
            folders = "/";
          }
          {
            format = "{$3}╰{$1}╯";
            type = "custom";
          }
        ];
      } |> builtins.replaceStrings [ "\\\\" ] [ "\\" ];

    xdg.configFile."fastfetch/logo_nix_white.png".source = "${path}/logo_nix_white.png";
  };
}
