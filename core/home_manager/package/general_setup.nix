{
  config,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    # ====
    # Nvim
    # ====
    # N
    # nvim/nvim.nix

    # =====
    # Other
    # =====
    # K
    other/keychain.nix

    # O
    other/nh.nix

    # R
    other/ruff.nix

    # ========
    # Terminal
    # ========
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
