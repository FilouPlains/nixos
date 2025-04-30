{ config, pkgs, ... }:

{
  imports =
    [
      # [[ Any ]]
      # S
      any/stylix.nix

      # [[ Nvim ]]
      # N
      nvim/nvim.nix

      # [[ Remote connexion ]]
      # K
      remote_connexion/keychain.nix
      remote_connexion/ssh.nix

      # [[ Terminal ]]
      # B
      terminal/btop.nix

      # F
      terminal/fastfetch.nix
      terminal/fish.nix

      # K
      terminal/kitty.nix

      # S
      terminal/starship.nix
    ];

  shiftAudio.enable = true;

  # Do not change this value.
  # If you want to do so, check `Home Manager release notes`.
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    MANROFFOPT "-P -c";
    MANPAGER = "nvimpager";
    PAGER = "nvimpager";
    COLORTERM = "truecolor";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
