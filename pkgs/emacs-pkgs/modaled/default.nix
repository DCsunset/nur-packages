{ stdenv, fetchFromGitHub, emacsWithPackages }:

stdenv.mkDerivation rec {
  name = "modaled";
  version = "c6d08582135dd047300e10b7a683151e4a9117af";

  src = fetchFromGitHub {
    owner = "DCsunset";
    repo = "modaled";
    rev = "${version}";
    hash = "sha256-Me2/QCXrS+pkxPONst56nMx2pJaFQvFzXz0nXGhrJmY=";
  };
  buildInputs = [
    (emacsWithPackages (epkgs: []))
  ];
  buildPhase = ''
    emacs -L . --batch -f batch-byte-compile *.el 2> stderr.txt
    cat stderr.txt
    ! grep -q ': Warning:' stderr.txt
  '';
  installPhase = ''
    LISPDIR=$out/share/emacs/site-lisp
    install -d $LISPDIR
    install *.el *.elc $LISPDIR
  '';
}
