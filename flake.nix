{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    stylix.url = "github:nix-community/stylix/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      "thanos" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./core/host/thanos/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      "vador" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./core/host/vador/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      "ashkar.behek" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./core/host/ashkar.behek/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
