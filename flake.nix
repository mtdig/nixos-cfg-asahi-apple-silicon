{
  description = "Jeroen's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-duckdb-144.url = "github:NixOS/nixpkgs/2fc6539b";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-esp-dev = {
      url = "github:mirrexagon/nixpkgs-esp-dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      rust-overlay,
      nixpkgs-duckdb-144,
      nixvim,
      nixpkgs-esp-dev,
      ...
    }:
    let
      system = "aarch64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          pkgs-esp-idf = nixpkgs-esp-dev.packages.${system};
          pkgs-duckdb-144 = nixpkgs-duckdb-144.legacyPackages.${system};

        };
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
            }
          )
          ./configuration.nix
        ];
      };
      homeConfigurations.jeroen = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          nixvim.homeModules.nixvim
          ./home.nix
        ];
      };
    };
}
