# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Custom Ultimaker Cura (macOS, currently 4.13.1) resource files for an Ultimaker 2 / 2+ modified into "Dual/Left" and "Dual/Right" single-extruder machine profiles, plus custom setting-visibility presets and third-party material profiles. There is no code to build or test. Everything is JSON/INI data that gets copied into the Cura app bundle.

## Commands

```sh
make install             # copy everything into the Cura.app bundle
make variant_install     # a single target: ultimaker_install, definition_install,
                         # variant_install, extruder_install, setting_install
make install APPPATH="/Applications/Ultimaker Cura X.Y.Z.app"   # override app location
```

`make` with no target does nothing. `material_install` and `material_quality_install` are commented out of `INSTALLS`. There is no `quality/` directory, so `material_quality_install` would fail. Run `material_install` by hand if you need it. Cura has to be restarted to pick up changes.

## How files map into Cura

| Repo dir | Installed to `$(RESPATH)/…` | Notes |
|---|---|---|
| `definitions/*.json` | `definitions/` | Machine definitions |
| `extruders/*.json` | `extruders/` | One extruder train per machine (`position: "0"`) |
| `variants/*.cfg` | `variants/` | Nozzle-size variants; `%{SETTING_VERSION}` is replaced by sed at install time |
| `settings/*.cfg` | `setting_visibility/` | Only `.cfg` files are installed; the `.exp` files are not |
| `materials/*.fdm_material` | `materials/` | Not installed by default |

`RESPATH` is the Cura.app `Contents/Resources/resources` directory. `CFGPATH` (the user config dir) is defined but not used by any rule.

## Architecture

- `definitions/ultimaker2.def.json` overwrites Cura's stock `ultimaker2` definition. `ultimaker2.def.json.orig` is the unmodified stock file from the matching Cura version, kept for diffing. `definition_install` copies every `*.json` in `definitions/`, so the modified base gets installed twice; `.orig` does not match the glob and is never installed.
- The dual machines (`ultimaker2_dual_left`, `ultimaker2_dual_right`, `ultimaker2_plus_dual_left`) all `inherit` from `ultimaker2`. Each one names its extruder in `machine_extruder_trains`. The extruder's `metadata.machine` and each variant's `definition =` field must match the machine id, which is the filename minus `.def.json`. Adding a machine therefore means adding a definition, an extruder, and one variant file per nozzle size.
- Each variant file sets `machine_nozzle_size` and `machine_nozzle_tip_outer_diameter`. The machine definition's `preferred_variant_name` ("0.4 mm") has to match a variant's `name`.

## Upgrading to a new Cura version

Past commits ("Modified for Cura 4.x") follow the same steps:

1. Update `VERSION`, `MAJOR` and `SETTING_VERSION` in the Makefile. `SETTING_VERSION` has to match the new Cura's `setting_version`, or Cura will reject the variants.
2. Replace `ultimaker2.def.json.orig` with the new stock `ultimaker2.def.json` from the app bundle.
3. Re-apply the local changes to `ultimaker2.def.json`. Diff it against the old `.orig` to see what those changes are.
