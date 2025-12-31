let
  hari = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE";
  verdigris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0y9mj8PDh6/Wno43k6k6B/UiCl0kTkkAuI0mC3KVK7";
  cyan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1aywGpoz8Scfkk9d5J/WAwWVHItD0aiMnOb69JlFcq";
in {
  "cf_api_token_hari_pm_dns.age" = {
    publicKeys = [hari verdigris];
    armor = true;
  };
  "miniflux_env.age" = {
    publicKeys = [hari verdigris];
    armor = true;
  };
  "miniflux_db_env.age" = {
    publicKeys = [hari verdigris];
    armor = true;
  };
  "linkding_env.age" = {
    publicKeys = [hari verdigris];
    armor = true;
  };

  "forgejo_token.age" = {
    publicKeys = [hari cyan];
    armor = true;
  };
}
