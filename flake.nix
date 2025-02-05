{
  description = "NixOS config flake";

  # NixOS current version!
  version = "release-24.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/${version}";

    home-manager = {
      url = "github:nix-community/home-manager/${version}";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/${version}";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./host/default/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
