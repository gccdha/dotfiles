{ pkgs,config, ... }:

{
  home.file.".config/colors/colors.txt".text = ''
    # Colors configuration
    base00 = ${config.colorScheme.pallete.base00}
    base01 = ${config.colorScheme.pallete.base01}
    base02 = ${config.colorScheme.pallete.base02}
    base03 = ${config.colorScheme.pallete.base03}
    base04 = ${config.colorScheme.pallete.base04}
    base05 = ${config.colorScheme.pallete.base05}
    base06 = ${config.colorScheme.pallete.base06}
    base07 = ${config.colorScheme.pallete.base07}
    base08 = ${config.colorScheme.pallete.base08}
    base09 = ${config.colorScheme.pallete.base09}
    base0A = ${config.colorScheme.pallete.base0A}
    base0B = ${config.colorScheme.pallete.base0B}
    base0C = ${config.colorScheme.pallete.base0C}
    base0D = ${config.colorScheme.pallete.base0D}
    base0E = ${config.colorScheme.pallete.base0E}
    base0F = ${config.colorScheme.pallete.base0F}
  '';
}

