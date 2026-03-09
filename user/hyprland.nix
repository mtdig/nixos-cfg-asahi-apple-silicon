{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {

      # ── Monitor ──
      monitor = [ "eDP-1, 2560x1600@60, 0x0, 1.5" ];

      # ── Environment ──
      env = [
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORM,wayland;xcb"
        "GDK_SCALE,1"
        "XCURSOR_SIZE,24"
      ];

      # ── Autostart ──
      exec-once = [
        "ironbar"
        "hyprpaper"
        "dunst"
        "hypridle"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
        "nm-applet --indicator"
        "blueman-applet"
      ];

      # ── General ──
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(7ebae4ee) rgba(5277c3ee) 45deg";
        "col.inactive_border" = "rgba(1a1b2600)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # ── Decoration ──
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          xray = false;
        };
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(0a0a1288)";
        };
        active_opacity = 1.0;
        inactive_opacity = 0.92;
      };

      # ── Animations ──
      animations = {
        enabled = true;
        bezier = [
          "ease, 0.25, 0.1, 0.25, 1"
          "easeOut, 0, 0, 0.58, 1"
          "easeInOut, 0.42, 0, 0.58, 1"
        ];
        animation = [
          "windows, 1, 4, ease, slide"
          "windowsOut, 1, 4, easeOut, slide"
          "fade, 1, 4, ease"
          "workspaces, 1, 4, easeInOut, slide"
          "border, 1, 6, ease"
        ];
      };

      # ── Input ──
      input = {
        kb_layout = "be-apple";
        kb_model = "apple_iso";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          clickfinger_behavior = true;
          drag_lock = true;
          scroll_factor = 0.7;
        };
      };

      gestures = {
        workspace_swipe_distance = 250;
      };

      # 3-finger horizontal swipe to change workspace (replaces removed workspace_swipe option)
      gesture = "3, horizontal, workspace";

      # ── Layout ──
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = true;
      };

      # ── Window rules ──
      windowrulev2 = [
        "float, class:^(pavucontrol)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "float, title:^(Picture-in-Picture)$"
        "float, class:^(xdg-desktop-portal-gtk)$"
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "size 800 500, class:^(pavucontrol)$"
        "size 800 500, class:^(blueman-manager)$"
        "opacity 0.9, class:^(ghostty)$"
      ];

      # ── Key bindings ──
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "rofi -show drun";
      "$browser" = "chromium";
      "$fileManager" = "dolphin";

      bind = [
        # ── Window switching (Alt+Tab) ──
        "ALT, Tab, cyclenext,"
        "ALT SHIFT, Tab, cyclenext, prev"
        "ALT, Tab, bringactivetotop,"

        # ── Apps ──
        "$mod, Return, exec, $terminal"
        "$mod, Space, exec, $menu"
        "$mod, B, exec, $browser"
        "$mod, E, exec, $fileManager"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # ── Window management ──
        "$mod, Q, killactive,"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        # ── Focus ──
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        # "$mod, J, movefocus, d"  # conflicts with togglesplit

        # ── Move windows ──
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # ── Resize ──
        "$mod CTRL, left, resizeactive, -40 0"
        "$mod CTRL, right, resizeactive, 40 0"
        "$mod CTRL, up, resizeactive, 0 -40"
        "$mod CTRL, down, resizeactive, 0 40"

        # ── Workspaces ──
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # ── Move to workspace ──
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # ── Special workspace (scratchpad) ──
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # ── Scroll through workspaces ──
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # ── Next/Previous workspace (Super + Fn+Left/Right = Super + Home/End) ──
        "$mod, Home, workspace, e-1"
        "$mod, End, workspace, e+1"

        # ── Screenshots ──
        ", Print, exec, hyprshot -m output"
        "SHIFT, Print, exec, hyprshot -m region"
        "CTRL, Print, exec, hyprshot -m window"
        "$mod SHIFT, P, exec, hyprshot -m output"
        "$mod SHIFT, R, exec, hyprshot -m region"
        "$mod SHIFT, W, exec, hyprshot -m window"

        # ── Zoom ──
        "$mod, equal, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | grep float | awk '{printf \"%.1f\", $2 + 0.5}')"
        "$mod, minus, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | grep float | awk '{z=$2-0.5; if(z<1) z=1; printf \"%.1f\", z}')"
        "$mod, 0, exec, hyprctl keyword cursor:zoom_factor 1"

        # ── Lock ──
        "$mod SHIFT, X, exec, hyprlock"

        # ── Logout menu ──
        "$mod SHIFT, Q, exec, wlogout"
      ];

      # ── Mouse binds ──
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # ── Media / hardware keys ──
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };

    extraConfig = ''
      bind = $mod, M, fullscreen, 1
    '';
  };

  # ── Hyprpaper (wallpaper) ──
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /run/current-system/sw/share/wallpapers/Next/contents/images/5120x2880.png
    wallpaper = , /run/current-system/sw/share/wallpapers/Next/contents/images/5120x2880.png
    splash = false
  '';

  # ── Hyprlock (lock screen) ──
  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = /run/current-system/sw/share/wallpapers/Next/contents/images/5120x2880.png
        blur_passes = 3
        blur_size = 6
        contrast = 0.8
        brightness = 0.6
        vibrancy = 0.2
    }

    input-field {
        monitor =
        size = 280, 50
        outline_thickness = 2
        dots_size = 0.25
        dots_spacing = 0.3
        outer_color = rgba(7ebae4ee)
        inner_color = rgba(0a0a1288)
        font_color = rgba(e8f0ffff)
        fade_on_empty = true
        placeholder_text = <i>Password...</i>
        position = 0, -80
        halign = center
        valign = center
    }

    label {
        monitor =
        text = <span font_weight="ultrabold" font_size="64" color="##7ebae4">$TIME</span>
        position = 0, 60
        halign = center
        valign = center
    }

    label {
        monitor =
        text = <span font_size="16" color="##c8ddf5">$USER on $HOST</span>
        position = 0, -20
        halign = center
        valign = center
    }
  '';

  # ── Hypridle (auto-lock / DPMS) ──
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
        timeout = 300
        on-timeout = brightnessctl -s set 30%
        on-resume = brightnessctl -r
    }

    listener {
        timeout = 600
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 900
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }
  '';

  # ── wlogout (logout menu) ──
  home.file.".config/wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "hyprlock",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "logout",
        "action" : "hyprctl dispatch exit",
        "text" : "Logout",
        "keybind" : "e"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
    }
  '';

  # ── Dunst (notifications) ──
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 350;
        height = 150;
        offset = "20x20";
        origin = "top-right";
        transparency = 15;
        frame_color = "#7ebae4";
        frame_width = 2;
        corner_radius = 10;
        font = "JetBrainsMono Nerd Font 10";
        padding = 12;
        horizontal_padding = 16;
        icon_position = "left";
        max_icon_size = 48;
        format = "<b>%s</b>\\n%b";
      };
      urgency_low = {
        background = "#0f1a30e6";
        foreground = "#c8ddf5";
        timeout = 5;
      };
      urgency_normal = {
        background = "#0f1a30e6";
        foreground = "#e8f0ff";
        frame_color = "#7ebae4";
        timeout = 8;
      };
      urgency_critical = {
        background = "#0f1a30e6";
        foreground = "#f7768e";
        frame_color = "#f7768e";
        timeout = 0;
      };
    };
  };
}
