{
  description = "A full rewrite of my system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # systems.url = "github:nix-systems/default";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix = {
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.systems.follows = "systems";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    agenix,
    disko,
  } @ inputs: let
    lib = nixpkgs.lib;
    createSystem = {
      host,
      user,
      platform,
      optionalModules,
    }:
      lib.nixosSystem {
        specialArgs = {inherit (inputs) self;};
        modules =
          [
            ./hosts/${host}
            ./users/${user}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = {inherit (inputs) self;};
              home-manager.users.${user} = import ./users/${user}/platforms/${platform}.nix;
            }
          ]
          ++ optionalModules;
      };
  in {
    nixosConfigurations = {
      seafoam = createSystem {
        host = "seafoam";
        user = "hari";
        platform = "pc";
        optionalModules = [
          nixos-hardware.nixosModules.dell-inspiron-14-5420
        ];
      };

      cerulean = createSystem {
        host = "cerulean";
        user = "hari";
        platform = "server";
      };

      verdigris = createSystem {
        host = "verdigris";
        user = "hari";
        platform = "server";
        optionalModules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
        ];
      };
    };
  };
}
