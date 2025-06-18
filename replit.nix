{ pkgs }: {
  channel = "stable-24_05";
  
  deps = [
    pkgs.libmysqlclient
  ];packages = [
    pkgs.libyaml
    pkgs.libyaml.dev
    pkgs.mysql
    pkgs.mysql.dev
    pkgs.mariadb.dev
    pkgs.pkg-config
    pkgs.gcc
    pkgs.gnumake
    pkgs.zlib
    pkgs.gmp
    pkgs.nodejs-20_x
    pkgs.yarn
    pkgs.openssh
  ];
}
