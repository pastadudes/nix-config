{ pkgs, lib, ... }:
{
  users.users.pastaya = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCVoMYaWMLeO2LhbgzinirZUfW8HfMlB70xdyMYf7KM2DrEFi/nYhzRDIq3WfjWOY4Y1TGpewEN1uzbKuZDoffJ0jwz1pGxK3eSNuCV6Pq4bSfT9wmtP2hLExqFoVWPa8koFCER+X3AoUV9zcnnrTvJhG6Q3w/mS2sizJjt9vDoJV/W6hRr8obmmoxnLXpV9ZKfaoXLbVUp3IXd/wHYy8QA1RQk9+gdHZFnzyRyVtpF3DlOJ+Dsv+6f2HXydc4heDv/Qsnzi2n40XwGdgyUHG5fP8pLiQWrL9CK/IO+Yap/P0obMrXr97dlIHHikw8xf8FMOdMvssnticzIdApH1IicySO3gF2LPpYN7a60YqcRGZZVAxzd69kbMj6YcJ0wk/04hCnJr2kymSm+MZTHKwzr5ewh614EakLSvaslpqDo6zy5VtmVLe2urqj0Ex4rpyrcR3GTdJw5ps4n5mcxJseRso3JU6wHjUQB/e1cffA6Dncz2QEpjGYYLEaaPF5JAHYsR6LOR1CtHdCCK4Tt71qbx1Uq2GbRWXqiH8uoWr9buygn4OTfOMm1hA1Pgq9AN6j013jYk308N3dj0LZ8HvJB5r3cfX/oLk7rYZ73Yp0/+nl2cm/Ls0iSwIuLC/aAkjtCV9sOFM3H+6O4SaMEhCrxz3gTGI/GGi8KTFcGG9vfiw== pastaya@pastaya"
    ];
    shell = pkgs.nushell;
    home = if pkgs.stdenv.isDarwin then "/Users/pastaya" else "/home/pastaya";
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "input"
      "audio"
      "flatpak"
    ];
  };
}
