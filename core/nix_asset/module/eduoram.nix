_: {
  networking.networkmanager.enable = true;

  environment.etc."ssl/certs/eduroam-ca.pem".source =
    /etc/ssl/certs/eduroam_ca.pem;

  networking.networkmanager.ensureProfiles.profiles.eduroam = {
    connection = {
      id = "eduroam";
      type = "wifi";
      autoconnect-priority = -10;
    };

    wifi.ssid = "eduroam";
    wifi-security.key-mgmt = "wpa-eap";

    "802-1x" = {
      anonymous-identity = "anonymous@u-paris.fr";
      ca-cert = "/etc/ssl/certs/eduroam-ca.pem";
      eap = "ttls";
      identity = "lucas.rouaud1";
      phase2-auth = "pap";

      altsubject-matches = builtins.concatStringsSep "" [
        "DNS:rad01.u-paris.fr;"
        "DNS:rad02.u-paris.fr;"
        "DNS:radcp.u-paris.fr"
      ];

      password-flags = 2;
    };

    ipv4.method = "auto";
    ipv6.method = "auto";
  };
}
