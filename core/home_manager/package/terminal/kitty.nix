{ config, lib, pkgs, osConfig, ... }:

let
  colour = config.stylix.base16Scheme;
  font = config.stylix.fonts;

  /** 
    Formats a tab title string for Kitty with custom colors.

    Parameters
    ----------
    foreground : `string`  
        The name of the foreground color to apply on the tab text.

    background : `string`  
        The name of the tab background color.

    reset : `string`  
        The `tab_bar_background` color.

    Returns
    -------
    `string`  
        The full Kitty setted tab.
  */
  tab_format = foreground: background: reset: (
    builtins.concatStringsSep "" [
      "{fmt.bg._${reset}} "
      "{fmt.fg._${background}}"
      "{fmt.bg._${background}}{fmt.fg._${foreground}}{index} {title}{bell_symbol}{activity_symbol}"
      "{fmt.bg._${reset}}{fmt.fg._${background}}"
      "{fmt.fg._${reset}} "
    ]
  );
in
{
  stylix.targets.kitty.enable = false;

  programs.kitty = {
    enable = !builtins.elem "kitty" osConfig.disabledPackage or true;

    settings = {
      # ===========
      # Font family
      # ===========
      font_family = "${font.monospace.name} Light";
      bold_font = "${font.monospace.name} Black";
      font_size = font.sizes.terminal;

      # ==========
      # Tabs style
      # ==========
      # Active.
      active_tab_font_style = "bold";
      active_tab_title_template = tab_format colour.base06 colour.base09 colour.base00;

      # Inactive.
      inactive_tab_font_style = "normal";
      tab_title_template = tab_format colour.base06 colour.base03 colour.base00;

      # Position and margin.
      tab_bar_edge = "top";
      tab_bar_align = "left";
      tab_bar_margin_width = 0;

      # Disabling separators.
      tab_bar_style = "separator";
      tab_separator = ''""'';

      tab_bar_min_tabs = 1;
      tab_bar_background = "#${colour.base00}";

      # ==============
      # General ground
      # ==============
      background = "#${colour.base00}";
      foreground = "#${colour.base05}";
      selection_background = "#${colour.base05}";
      selection_foreground = "#${colour.base00}";

      # ===================
      # Other color setting
      # ===================
      url_color = "#${colour.base04}";
      cursor = "#${colour.base05}";
      active_border_color = "#${colour.base03}";
      inactive_border_color = "#${colour.base01}";

      # ==============
      # Normal colours
      # ==============
      color0 = "#${colour.base00}";
      color1 = "#${colour.base08}";
      color2 = "#${colour.base0B}";
      color3 = "#${colour.base0A}";
      color4 = "#${colour.base0D}";
      color5 = "#${colour.base0E}";
      color6 = "#${colour.base0C}";
      color7 = "#${colour.base05}";

      # ==============
      # Bright colours
      # ==============
      color8 = "#${colour.base03}";
      color9 = "#${colour.base09}";
      color10 = "#${colour.base01}";
      color11 = "#${colour.base02}";
      color12 = "#${colour.base04}";
      color13 = "#${colour.base06}";
      color14 = "#${colour.base05}";
      color15 = "#${colour.base07}";
    };
  };
}
