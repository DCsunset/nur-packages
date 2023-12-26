{ lib, fuse3, makeWrapper, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "rangefs";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "DCsunset";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-xN/OFYxWVEke0YQCUoCcBAjflJwIfW9Y0XNQpnCsIl0=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];
  cargoHash = "sha256-gmSwg3ahWT0wUCIAr88O6RaHGewbxoC/JGIP2bKsBxg=";

  # reference: https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/filesystems/gocryptfs/default.nix
  postInstall = ''
    wrapProgram $out/bin/rangefs \
      --suffix PATH : ${lib.makeBinPath [ fuse3 ]}
    ln -s $out/bin/rangefs $out/bin/mount.fuse.rangefs
  '';

  meta = with lib; {
    description = "A fuse-based filesystem to map ranges in file to individual files.";
    homepage = "https://github.com/DCsunset/rangefs";
    license = licenses.agpl3;
  };
}
