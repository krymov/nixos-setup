{
  description = "i have no idea how this works";

  inputs =
    {
      # Package sources.
      master.url = "github:nixos/nixpkgs/master";
      stable.url = "github:nixos/nixpkgs/nixos-24.05";
      unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager";
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      spicetify-nix.url = "github:the-argus/spicetify-nix";


      nur.url = "github:nix-community/NUR";
      nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
      nix-gaming.url = "github:fufexan/nix-gaming";

      hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
      };
      hyprland.url = "github:hyprwm/Hyprland";

      ags.url = "github:ozwaldorf/ags";

      home-manager.inputs.nixpkgs.follows = "unstable";
      nixpkgs.follows = "unstable";


    };
  outputs = { self, nixpkgs, home-manager, hyprland, hyprland-plugins, ... } @inputs:
      let
      inherit (self) outputs;
      forSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem
          {
            specialArgs = {
              inherit inputs outputs home-manager hyprland hyprland-plugins;
            };
            modules = [
              # > Our main nixos configuration file <
              ./hosts/t480/configuration.nix
              home-manager.nixosModules.home-manager
	      {
	        home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;

		home-manager.users.m = import ./home/m/home.nix;
	      }
	      # ./home-manager/mark/home.nix 
            ];
          };
      };
      # home-manager = home-manager.packages.${nixpkgs.system}."home-manager";

      nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;
    };
}

