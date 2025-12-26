let
  hari = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE";
  verdigris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0y9mj8PDh6/Wno43k6k6B/UiCl0kTkkAuI0mC3KVK7";
in {
  "cf_api_token_hari_pm_dns.age" = {
    publicKeys = [hari verdigris];
    armor = true;
  };
}
