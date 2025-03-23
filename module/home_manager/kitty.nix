{ config, lib, pkgs, ... }:

let
  stylix = config.lib.stylix.colors;

  /**
    Formats a tab title string for Kitty with custom colors.

    @param color : `string`
        A string representing the color code to use for styling the tab.

    @return `string`
        Definition of the tab appearance.
  */
  tab_format = color: (
    builtins.concatStringsSep "" [
      "{fmt.bg.default} "
      "{fmt.fg._${color}}"
      "{fmt.bg._${color}}{fmt.fg._ffffff}{index} {title}{bell_symbol}{activity_symbol}"
      "{fmt.bg.default}{fmt.fg._${color}}"
      "{fmt.fg.default} "
    ]
  );
in
{
  programs.kitty = {
    enable = true;
    
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
      active_tab_title_template = tab_format stylix.base09;

      # Inactive.
      inactive_tab_font_style = "normal";
      tab_title_template = tab_format stylix.base01;

      # Position and margin.
      tab_bar_edge = "top";
      tab_bar_align = "left";
      tab_bar_margin_width = 0;

      # Disabling separators.
      tab_bar_style = "separator";
      tab_separator = ''""'';
     
    };

    # Have to applied this parameter like that, so it override stylix value.
    extraConfig = ''
      tab_bar_background none
    '';
  };
}
