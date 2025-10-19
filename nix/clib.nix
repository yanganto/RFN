{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "MyCLib";
  src = ../clib;
  buildPhase = ''
    ${pkgs.gcc}/bin/cc -c arradd.c
    ${pkgs.gcc}/bin/ar -cvq libarradd.a arradd.o
  '';
  installPhase = ''
    mkdir -p $out
    cp arradd.c $out/
    cp arradd.h $out/
    cp arradd.o $out/
    cp libarradd.a $out/
  '';
}
