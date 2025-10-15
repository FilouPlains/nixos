{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: {
  programs.ruff = {
    enable = !builtins.elem "ruff" osConfig.disabledPackage or true;

    settings = {
      line-length = 79;
      indent-width = 4;

      format = {
        quote-style = "double";
        indent-style = "space";
      };
    };

    #             ╰─ catf pyproject.toml
    # [tool.ruff]
    # line-length = 79
    # indent-width = 4
    #
    # [tool.ruff.format]
    # quote-style = "double"
    # indent-style = "space"
  };
}
