{
  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      nix-darwin,
      ...
    }:
    let
      overlays = [
        (final: prev: {
          zrythm = prev.callPackage ./zrythm-fixed.nix { };
        })
      ];

    in
    {
      nixosConfigurations = {
        # almost basically on life support...
        t2nix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              imports = [
                ./hosts/t2-firmware/t2-hardware-configuration.nix
                ./defaults.nix
                ./hosts/t2.nix
                ./desktopServices.nix
                ./desktopPackages.nix
                # ./hosts/t2-firmware/pipewire_sink_conf.nix
                nixos-hardware.nixosModules.apple-t2
              ];
            }
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              imports = [
                # ./hosts/t2-hardware-configuration.nix
                ./defaults.nix
                ./hosts/server.nix
                ./hosts/server-hardware-configuration.nix
                ./serverPackages.nix
                ./serverServices.nix
              ];
            }
          ];
        };
      };
      darwinConfigurations = {
        daramd = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./darwin.nix
            ./hosts/daramd.nix
            ./darwinPackages.nix
          ];
        };
      };
    };
}
