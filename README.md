# NixOS configuration

## Get specific versions

https://www.nixhub.io/


## If issues with stylix

```fish
nix flake update stylix/base16
```

## To run `Stirling-PDF`

```fish
nix-shell --command fish --packages \
    stirling-pdf \
    ghostscript_headless \
    ocrmypdf \
    python312Packages.weasyprint \
    poppler-utils \
    unoconv \
    opencv

Stirling-PDF
```
