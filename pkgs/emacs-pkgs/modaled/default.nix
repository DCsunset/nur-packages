{ stdenv, fetchFromGitHub, emacsWithPackages }:

stdenv.mkDerivation rec {
  name = "modaled";
  version = "d66bcae5dbb30c89cb866c96d37a0187991f46c5";

  src = fetchFromGitHub {
    owner = "DCsunset";
    repo = "modaled";
    rev = "${version}";
    hash = "sha256-PUog6RSnKpaRC4JH6xp02+dkjymrLTfuLHhPz+oLMpE=";
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
