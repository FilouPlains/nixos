{ stdenv, buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "g";
  version = "0.29.0";

  src = fetchFromGitHub {
    owner = "Equationzhao";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nQzeMlJwvGUAX53QRe4zcRx8OoTu65uHpmD2vkPkJac=";
  };

  vendorHash = "sha256-pAr/A731tzrWsCogaXD4fVSdC4kF+B2E+QXOSjHU18g=";

  ldflags = [ "-s" "-w" ];

  doCheck = false;

  meta = with lib; {
    description = "Powerful and cross-platform ls 🌈 built for modern terminal";
    homepage = "https://github.com/Equationzhao/${pname}";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
