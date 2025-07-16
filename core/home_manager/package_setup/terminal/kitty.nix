{ config, lib, pkgs, osConfig, ... }:

let
  stylix = config.lib.stylix.colors;

  /** 
    Formats a tab title string for Kitty with custom colors.
    
    Parameters
    ----------
    foreground : `string`  
        The name of the foreground color to apply on the tab text.
    
    background : `string`  
        The name of the tab background color.
    
    Returns
    -------
    `string`  
        The full Kitty setted tab.
  */
  tab_format = foreground: background: (
    builtins.concatStringsSep "" [
      "{fmt.bg.default} "
      "{fmt.fg._${background}}"
      "{fmt.bg._${background}}{fmt.fg._${foreground}}{index} {title}{bell_symbol}{activity_symbol}"
      "{fmt.bg.default}{fmt.fg._${background}}"
      "{fmt.fg.default} "
    ]
  );
in
{
  programs.kitty = {
    enable = !builtins.elem "kitty" osConfig.disabledPackage or true;

    settings = {
      # ===========
      # FONT FAMILY
      # ===========
      font_family = "Inconsolata Light";
      bold_font = "Inconsolata Black";

      # ==========
      # TABS STYLE
      # ==========
      # Active.
      active_tab_font_style = "bold";
      active_tab_title_template = tab_format stylix.base06 stylix.base09;

      # Inactive.
      inactive_tab_font_style = "normal";
      tab_title_template = tab_format stylix.base06 stylix.base01;

      # Position and margin.
      tab_bar_edge = "top";
      tab_bar_align = "left";
      tab_bar_margin_width = 0;

      # Disabling separators.
      tab_bar_style = "separator";
      tab_separator = ''""'';

      tab_bar_min_tabs = 1;
    };

    # Have to applied this parameter like that, so it override stylix value.
    extraConfig = ''
      tab_bar_background none
    '';
  };
}
