# Seafoamnix

This repo contains Nix configuration for my personal computer and dev servers.
It is based on [Naomi Roberts' excellent NixOS configuration files](https://tangled.org/lesbian.skin/amuro/tree/main).

| System  | Arch           | Description |
|---------|----------------|-------------|
| seafoam | `x86-64_linux` | My laptop   |

## Structure

```
├── flake.nix
├── hosts         # Systems managed by this config
│   └── seafoam
├── modules       # Modular pieces of the config
│   ├── home      # Home Manager modules
│   └── nixos     # System modules
└── users         # Users for the hosts
    └── hari
```

