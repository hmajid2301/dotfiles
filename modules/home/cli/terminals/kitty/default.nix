{
  config,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.terminals.kitty;
in {
  options.cli.terminals.kitty = with types; {
    enable = mkBoolOpt false "enable kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      settings = {
        shell = "fish";
        window_padding_width = 10;
        scrollback_lines = 10000;
        show_hyperlink_targets = "no";
        enable_audio_bell = false;
        url_style = "none";
        underline_hyperlinks = "never";
        copy_on_select = "clipboard";
        symbol_map = let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
            "U+E000-U+E00A"
            "U+EA60-U+EBEB"
            "U+E0A0-U+E0C8"
            "U+E0CA"
            "U+E0CC-U+E0D4"
            "U+E200-U+E2A9"
            "U+E300-U+E3E3"
            "U+E5FA-U+E6B1"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+F300-U+F372"
            "U+F400-U+F532"
            "U+F0001-U+F1AF0"
          ];
          emoji = [
            "U+2600-U+26FF"
            "U+1F600-U+1F64F"
          ];
        in
          (builtins.concatStringsSep "," mappings)
          + " Symbols Nerd Font Mono"
          + "\n"
          # TODO: use stylix config here
          + (builtins.concatStringsSep "," emoji)
          + " Noto Emoji Font";
      };
    };
  };
}
