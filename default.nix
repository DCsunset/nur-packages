# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

let
  mylib = import ./lib { inherit pkgs; }; # functions
in {
  # The `lib`, `modules`, and `overlay` names are special
  lib = mylib;
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  emacsPackages = builtins.listToAttrs (
    map (p: {
      name = p;
      value = pkgs.callPackage (./pkgs/emacs + "/${p}") { };
    }) (mylib.listSubdirNames ./pkgs/emacs)
  );
} // (builtins.listToAttrs (
  # top-level
  map (p: {
    name = p;
    value = pkgs.callPackage (./pkgs/top-level + "/${p}") { };
  }) (mylib.listSubdirNames ./pkgs/top-level)
))
