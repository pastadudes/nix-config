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
    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      nix-darwin,
      home-manager,
      ...
    }:
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
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.pastaya = ./home/home.nix;
                  home-manager.backupFileExtension = "before-home-manager";
                }
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
                ./bytes.nix

                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.pastaya = ./home/home.nix;
                  home-manager.backupFileExtension = "before-home-manager";
                }
              ];
            }
          ];
        };
      };
      
      darwinConfigurations = {
        daramd = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./darwin.nix
            ./hosts/daramd.nix
            ./darwinPackages.nix

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pastaya = ./home/home.nix;
              home-manager.backupFileExtension = "before-home-manager";
            }
          ];
        };
      };
    };
}
