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
  } @ inputs: let
    lib = nixpkgs.lib;
    createSystem = {
      host,
      user,
      platform,
      hardwareModules,
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
          ++ hardwareModules;
      };
  in {
    nixosConfigurations = {
      seafoam = createSystem {
        host = "seafoam";
        user = "hari";
        platform = "pc";
        hardwareModules = [
          nixos-hardware.nixosModules.dell-inspiron-14-5420
        ];
      };
    };
  };
}
