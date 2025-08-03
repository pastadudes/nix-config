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
   };

  outputs = { nixpkgs, nixos-hardware, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    formatter.${system} = pkgs.nixfmt-rfc-style;

    nixosConfigurations = {
      t2nix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ config, pkgs, ... }: {
            imports = [
              ./hosts/t2-firmware/t2-hardware-configuration.nix
              ./defaults.nix 
              ./hosts/t2.nix
              ./desktopServices.nix
              ./desktopPackages.nix
              # ./hosts/t2-firmware/pipewire_sink_conf.nix
              nixos-hardware.nixosModules.apple-t2
            ];
          })
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ config, pkgs, ... }: {
            imports = [
              # ./hosts/t2-hardware-configuration.nix
              ./defaults.nix 
              ./hosts/server.nix
              ./hosts/server-hardware-configuration.nix
              ./serverPackages.nix
              ./serverServices.nix
            ];
          })
        ];
      };
    };
  };
}
