{ config
, pkgs
, inputs
, ...
}: {
  gtk = {
    enable = true;
    font = {
      name = config.my.settings.fonts.regular;
      size = 12;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };

    gtk3.extraCss =
      ''
        @define-color accent_color rgb(116, 199, 236);
        @define-color accent_bg_color rgb(137, 180, 250);
        @define-color accent_fg_color rgb(17, 17, 27);
        @define-color destructive_color rgb(238, 153, 160);
        @define-color destructive_bg_color rgb(237, 135, 150);
        @define-color destructive_fg_color rgb(17, 17, 27);
        @define-color success_color rgb(166, 218, 149);
        @define-color success_bg_color rgb(139, 213, 202);
        @define-color success_fg_color rgb(17, 17, 27);
        @define-color warning_color rgb(245, 169, 127);
        @define-color warning_bg_color rgb(238, 212, 159);
        @define-color warning_fg_color rgb(17, 17, 27);
        @define-color error_color rgb(238, 153, 160);
        @define-color error_bg_color rgb(237, 135, 150);
        @define-color error_fg_color rgb(17, 17, 27);
        @define-color window_bg_color rgb(30, 30, 46);
        @define-color window_fg_color rgb(205, 214, 244);
        @define-color view_bg_color rgb(24, 24, 37);
        @define-color view_fg_color rgb(205, 214, 244);
        @define-color headerbar_bg_color rgb(17, 17, 27);
        @define-color headerbar_fg_color rgb(205, 214, 244);
        @define-color headerbar_border_color rgb(49, 50, 68);
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
        @define-color card_bg_color rgb(24, 24, 37);
        @define-color card_fg_color rgb(205, 214, 244);
        @define-color card_shade_color rgba(0, 0, 0, 0.36);
        @define-color dialog_bg_color rgb(24, 24, 37);
        @define-color dialog_fg_color rgb(205, 214, 244);
        @define-color popover_bg_color rgb(24, 24, 37);
        @define-color popover_fg_color rgb(205, 214, 244);
        @define-color shade_color rgba(0,0,0,0.36);
        @define-color scrollbar_outline_color rgba(0,0,0,0.5);
        @define-color blue_1 #99c1f1;
        @define-color blue_2 #62a0ea;
        @define-color blue_3 #3584e4;
        @define-color blue_4 #1c71d8;
        @define-color blue_5 #1a5fb4;
        @define-color green_1 #8ff0a4;
        @define-color green_2 #57e389;
        @define-color green_3 #33d17a;
        @define-color green_4 #2ec27e;
        @define-color green_5 #26a269;
        @define-color yellow_1 #f9f06b;
        @define-color yellow_2 #f8e45c;
        @define-color yellow_3 #f6d32d;
        @define-color yellow_4 #f5c211;
        @define-color yellow_5 #e5a50a;
        @define-color orange_1 #ffbe6f;
        @define-color orange_2 #ffa348;
        @define-color orange_3 #ff7800;
        @define-color orange_4 #e66100;
        @define-color orange_5 #c64600;
        @define-color red_1 #f66151;
        @define-color red_2 #ed333b;
        @define-color red_3 #e01b24;
        @define-color red_4 #c01c28;
        @define-color red_5 #a51d2d;
        @define-color purple_1 #dc8add;
        @define-color purple_2 #c061cb;
        @define-color purple_3 #9141ac;
        @define-color purple_4 #813d9c;
        @define-color purple_5 #613583;
        @define-color brown_1 #cdab8f;
        @define-color brown_2 #b5835a;
        @define-color brown_3 #986a44;
        @define-color brown_4 #865e3c;
        @define-color brown_5 #63452c;
        @define-color light_1 #ffffff;
        @define-color light_2 #f6f5f4;
        @define-color light_3 #deddda;
        @define-color light_4 #c0bfbc;
        @define-color light_5 #9a9996;
        @define-color dark_1 #77767b;
        @define-color dark_2 #5e5c64;
        @define-color dark_3 #3d3846;
        @define-color dark_4 #241f31;
        @define-color dark_5 #000000;

        .sidebar-pane {
        	background-color: #14141e;
        	color: #FFFFFF;
        }
      '';

    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-decoration-layout = "appmenu:none";
      gtk-button-images = 1;
      gtk-menu-images = 1;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-decoration-layout = "appmenu:none";
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraCss = ''
      		@define-color accent_color rgb(116, 199, 236);
      @define-color accent_bg_color rgb(137, 180, 250);
      @define-color accent_fg_color rgb(17, 17, 27);
      @define-color destructive_color rgb(238, 153, 160);
      @define-color destructive_bg_color rgb(237, 135, 150);
      @define-color destructive_fg_color rgb(17, 17, 27);
      @define-color success_color rgb(166, 218, 149);
      @define-color success_bg_color rgb(139, 213, 202);
      @define-color success_fg_color rgb(17, 17, 27);
      @define-color warning_color rgb(245, 169, 127);
      @define-color warning_bg_color rgb(238, 212, 159);
      @define-color warning_fg_color rgb(17, 17, 27);
      @define-color error_color rgb(238, 153, 160);
      @define-color error_bg_color rgb(237, 135, 150);
      @define-color error_fg_color rgb(17, 17, 27);
      @define-color window_bg_color rgb(30, 30, 46);
      @define-color window_fg_color rgb(205, 214, 244);
      @define-color view_bg_color rgb(24, 24, 37);
      @define-color view_fg_color rgb(205, 214, 244);
      @define-color headerbar_bg_color rgb(17, 17, 27);
      @define-color headerbar_fg_color rgb(205, 214, 244);
      @define-color headerbar_border_color rgb(49, 50, 68);
      @define-color headerbar_backdrop_color @window_bg_color;
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
      @define-color card_bg_color rgb(24, 24, 37);
      @define-color card_fg_color rgb(205, 214, 244);
      @define-color card_shade_color rgba(0, 0, 0, 0.36);
      @define-color dialog_bg_color rgb(24, 24, 37);
      @define-color dialog_fg_color rgb(205, 214, 244);
      @define-color popover_bg_color rgb(24, 24, 37);
      @define-color popover_fg_color rgb(205, 214, 244);
      @define-color shade_color rgba(0,0,0,0.36);
      @define-color scrollbar_outline_color rgba(0,0,0,0.5);
      @define-color blue_1 #99c1f1;
      @define-color blue_2 #62a0ea;
      @define-color blue_3 #3584e4;
      @define-color blue_4 #1c71d8;
      @define-color blue_5 #1a5fb4;
      @define-color green_1 #8ff0a4;
      @define-color green_2 #57e389;
      @define-color green_3 #33d17a;
      @define-color green_4 #2ec27e;
      @define-color green_5 #26a269;
      @define-color yellow_1 #f9f06b;
      @define-color yellow_2 #f8e45c;
      @define-color yellow_3 #f6d32d;
      @define-color yellow_4 #f5c211;
      @define-color yellow_5 #e5a50a;
      @define-color orange_1 #ffbe6f;
      @define-color orange_2 #ffa348;
      @define-color orange_3 #ff7800;
      @define-color orange_4 #e66100;
      @define-color orange_5 #c64600;
      @define-color red_1 #f66151;
      @define-color red_2 #ed333b;
      @define-color red_3 #e01b24;
      @define-color red_4 #c01c28;
      @define-color red_5 #a51d2d;
      @define-color purple_1 #dc8add;
      @define-color purple_2 #c061cb;
      @define-color purple_3 #9141ac;
      @define-color purple_4 #813d9c;
      @define-color purple_5 #613583;
      @define-color brown_1 #cdab8f;
      @define-color brown_2 #b5835a;
      @define-color brown_3 #986a44;
      @define-color brown_4 #865e3c;
      @define-color brown_5 #63452c;
      @define-color light_1 #ffffff;
      @define-color light_2 #f6f5f4;
      @define-color light_3 #deddda;
      @define-color light_4 #c0bfbc;
      @define-color light_5 #9a9996;
      @define-color dark_1 #77767b;
      @define-color dark_2 #5e5c64;
      @define-color dark_3 #3d3846;
      @define-color dark_4 #241f31;
      @define-color dark_5 #000000;

      .sidebar-pane {
      	background-color: #11111b;
      	color: #FFFFFF;
      }
    '';
  };


  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  home.sessionVariables.GTK_THEME = "Adwaita-dark";
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}
