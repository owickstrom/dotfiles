{ mkDerivation, ansi-terminal, base, directory, filepath, process
, stdenv, unix
}:
mkDerivation {
  pname = "dotfiles";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    ansi-terminal base directory filepath process unix
  ];
  homepage = "https://github.com/owickstrom/dotfiles#readme";
  description = "Oskar Wickstrom's dotfiles";
  license = stdenv.lib.licenses.mit;
}
