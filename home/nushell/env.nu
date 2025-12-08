$env.PATH ++= ["/run/current-system/sw/bin", "/etc/profiles/per-user/pastaya/bin", "~/.cargo/bin"]
$env.PAGER = ^less

# i realized that some other shells have extra vars i don't have
$env.NIX_PATH = ["nixpkgs=flake:nixpkgs", "/nix/var/nix/profiles/per-user/root/channels"]
$env.NIX_PROFILES = [
    "/nix/var/nix/profiles/default", 
    "/run/current-system/sw", 
    "/etc/profiles/per-user/pastaya", 
    "$HOME/.nix-profile"
]

$env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
$env.NIX_USER_PROFILE_DIR = "/nix/var/nix/profiles/per-user/pastaya"


if ^uname == "Darwin" {
  $env.PATH = $env.PATH | prepend '/usr/bin'

  $env.PATH ++= ["/usr/local/bin/"]
}

# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
# mkdir $"($nu.cache-dir)"
# /run/current-system/sw/bin/carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

