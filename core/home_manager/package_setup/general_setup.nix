{ config, pkgs, osConfig, ... }:

{
  imports =
    [
      # [[ Any ]]
      # S
      any/stylix.nix

      # [[ Nvim ]]
      # N
      # nvim/nvim.nix

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
}
