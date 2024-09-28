{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "vban";
  version = "2024-09-28";  # Update to the latest version or a specific commit
  
  src = pkgs.fetchFromGitHub {
    owner = "quiniouben";
    repo = "vban";
    rev = "master";
    sha256 = "sha256-V7f+jcj3NpxXNr15Ozx2is4ReeeVpl3xvelMuPNfNT0=";  
  };
  
  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];
  buildInputs = [ pkgs.cmake pkgs.pkg-config pkgs.alsaLib pkgs.pulseaudio.dev pkgs.jack2.dev ];  # Include additional dependencies here

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_VERBOSE_MAKEFILE=OFF"
    "-DCMAKE_C_FLAGS=-w"
    "-DWITH_ALSA=Yes"
    "-DWITH_PULSEAUDIO=Yes"
    "-DWITH_JACK=Yes"  
  ];

  meta = with pkgs.lib; {
    description = "A C++ library and tools for VBAN protocol";
    homepage = "https://github.com/quiniouben/vban";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
