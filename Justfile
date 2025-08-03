# just is a command runner, Justfile is very similar to Makefile, but simpler.
# ryans Justfile but i chnaged it a bit to be NOT depracted or whatever i cant spell

# in specifc i changed all --use-remote-sudo to --sudo instead
# commenting idols because i dont have a nixos server YET

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

deploy:
  sudo nixos-rebuild switch --flake . 
debug:
  sudo nixos-rebuild build --flake . --show-trace --verbose

up:
 nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake update $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

############################################################################
#
#  Idols, Commands related to my remote distributed building cluster
#
############################################################################
# <<<<<<< HEAD
#
# add-idols-ssh-key:
#   ssh-add ~/.ssh/ai-idols
#
# aqua: add-idols-ssh-key
#   nixos-rebuild --flake .#aquamarine --target-host aquamarine --build-host aquamarine switch --sudo
#
# aqua-debug: add-idols-ssh-key
#   nixos-rebuild --flake .#aquamarine --target-host aquamarine --build-host aquamarine switch --sudo --show-trace --verbose
#
#=======

pasta:
  nixos-rebuild --flake .#server --target-host usest1.netro.host --build-host pastaya switch --sudo

pasta-debug:
  nixos-rebuild --flake .#server --target-host usest1.netro.host --build-host pastaya switch --sudo --show-trace --verbose

# >>>>>>> 8833a3b (reinit git for the 3rd time)
# ruby: add-idols-ssh-key
#   nixos-rebuild --flake .#ruby --target-host ruby --build-host ruby switch --sudo
#
# ruby-debug: add-idols-ssh-key
#   nixos-rebuild --flake .#ruby --target-host ruby --build-host ruby switch --sudo --show-trace --verbose
#
# kana: add-idols-ssh-key
#   nixos-rebuild --flake .#kana --target-host kana --build-host kana switch --sudo
#
# kana-debug: add-idols-ssh-key
#   nixos-rebuild --flake .#kana --target-host kana --build-host kana switch --sudo --show-trace --verbose
#
# idols: aqua ruby kana
#
# idols-debug: aqua-debug ruby-debug kana-debug
