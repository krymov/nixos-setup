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




    };
  outputs = { self, nixpkgs, ... } @inputs:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem
          {
            modules = [
              # > Our main nixos configuration file <
              # inputs.home-manager.nixosModule
              # inputs.darkmatter.nixosModule
              ./hosts/t480/configuration.nix
            ];
          };
      };

      nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;
    };
}

