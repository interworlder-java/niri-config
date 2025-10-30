{
  description = "My niri config wrapper";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers.url = "github:lassulus/wrappers";
  };

  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      ...
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages."x86_64-linux".niri = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.niri;
        flags = {
          "--config" = ./config.kdl;
        };
      };

      defaultPackage."x86_64-linux" = self.packages."x86_64-linux".niri;
    };
}
