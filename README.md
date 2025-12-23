# NixOS configuration

## Get specific versions

https://www.nixhub.io/


## If issues with stylix

```fish
nix flake update stylix/base16
```

## To run `Stirling-PDF`

```fish
nix-shell \
    --command Stirling-PDF \
    --packages \
           stirling-pdf \
           ghostscript_headless \
           ocrmypdf \
           python312Packages.weasyprint \
           poppler-utils \
           unoconv \
           python313Packages.opencv-python-headless \
           qpdf \
           tesseract4 \
           rar
```
