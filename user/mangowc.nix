{ pkgs, ... }:

{
  # ── MangoWC autostart script ──
  home.file.".config/mango/autostart.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      # Environment
      export NIXOS_OZONE_WL=1
      export ELECTRON_OZONE_PLATFORM_HINT=auto
      export QT_QPA_PLATFORM="wayland;xcb"
      export GDK_SCALE=1
      export XCURSOR_SIZE=24

      # Display scale
      sleep 0.5
      wlr-randr --output eDP-1 --scale 1.5 &

      # Bar
      ironbar &

      # Wallpaper
      hyprpaper &

      # Notifications
      dunst &

      # Idle daemon
      hypridle &

      # Clipboard
      wl-paste --type text --watch cliphist store &
      wl-paste --type image --watch cliphist store &

      # Polkit
      ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

      # Tray applets
      nm-applet --indicator &
      blueman-applet &
    '';
  };

  # ── MangoWC config ──
  home.file.".config/mango/config.conf".text = ''
    # ── Window effects ──
    blur=1
    blur_layer=0
    blur_optimized=1
    blur_params_num_passes=3
    blur_params_radius=6
    blur_params_noise=0.02
    blur_params_brightness=0.9
    blur_params_contrast=0.9
    blur_params_saturation=1.2

    shadows=1
    layer_shadows=0
    shadow_only_floating=1
    shadows_size=12
    shadows_blur=15
    shadows_position_x=0
    shadows_position_y=0
    shadowscolor=0x0a0a1288

    border_radius=10
    no_radius_when_single=0
    focused_opacity=1.0
    unfocused_opacity=0.92

    # ── Animation ──
    animations=1
    layer_animations=1
    animation_type_open=slide
    animation_type_close=slide
    animation_fade_in=1
    animation_fade_out=1
    tag_animation_direction=0
    zoom_initial_ratio=0.3
    zoom_end_ratio=0.8
    fadein_begin_opacity=0.5
    fadeout_begin_opacity=0.8
    animation_duration_move=400
    animation_duration_open=400
    animation_duration_tag=350
    animation_duration_close=400
    animation_duration_focus=0
    animation_curve_open=0.25,0.1,0.25,1
    animation_curve_move=0.25,0.1,0.25,1
    animation_curve_tag=0.42,0,0.58,1
    animation_curve_close=0.25,0.1,0.25,1
    animation_curve_focus=0.25,0.1,0.25,1

    # ── Layout ──
    new_is_master=1
    default_mfact=0.55
    default_nmaster=1
    smartgaps=0

    # ── Overview ──
    hotarea_size=10
    enable_hotarea=1
    ov_tab_mode=0
    overviewgappi=5
    overviewgappo=30

    # ── Misc ──
    no_border_when_single=0
    focus_on_activate=1
    sloppyfocus=1
    warpcursor=1
    cursor_size=24
    drag_tile_to_tile=1

    # ── Keyboard (Belgian Apple) ──
    repeat_rate=25
    repeat_delay=600
    numlockon=0
    xkb_rules_layout=be-apple

    # ── Trackpad ──
    disable_trackpad=0
    tap_to_click=1
    tap_and_drag=1
    drag_lock=1
    trackpad_natural_scrolling=1
    disable_while_typing=1
    left_handed=0
    middle_button_emulation=0
    swipe_min_threshold=1

    # ── Mouse ──
    mouse_natural_scrolling=0

    # ── Gaps ──
    gappih=4
    gappiv=4
    gappoh=8
    gappov=8

    # ── Appearance (NixOS blue theme) ──
    borderpx=2
    rootcolor=0x0f1a30ff
    bordercolor=0x1a1b2600
    focuscolor=0x7ebae4ee
    maximizescreencolor=0x5277c3ee
    urgentcolor=0xf7768eff
    scratchpadcolor=0x516c93ff
    globalcolor=0xb153a7ff
    overlaycolor=0x14a57cff

    # ── Tag layouts ──
    tagrule=id:1,layout_name:tile
    tagrule=id:2,layout_name:tile
    tagrule=id:3,layout_name:tile
    tagrule=id:4,layout_name:tile
    tagrule=id:5,layout_name:tile
    tagrule=id:6,layout_name:tile
    tagrule=id:7,layout_name:tile
    tagrule=id:8,layout_name:tile
    tagrule=id:9,layout_name:tile

    # ── Key Bindings ──

    # Reload config
    bind=SUPER,r,reload_config

    # Apps
    bind=SUPER,Return,spawn,ghostty
    bind=SUPER,space,spawn,rofi -show drun
    bind=SUPER,b,spawn,chromium
    bind=SUPER,e,spawn,dolphin

    # Window management
    bind=SUPER,q,killclient,
    bind=ALT,f,togglefullscreen,
    bind=SUPER,f,togglefullscreen,
    bind=SUPER+SHIFT,f,togglefloating,
    bind=ALT,a,togglemaximizescreen,
    bind=SUPER,m,togglemaximizescreen,

    # Focus
    bind=SUPER,Left,focusdir,left
    bind=SUPER,Right,focusdir,right
    bind=SUPER,Up,focusdir,up
    bind=SUPER,Down,focusdir,down
    bind=SUPER,h,focusdir,left
    bind=SUPER,l,focusdir,right
    bind=SUPER,k,focusdir,up
    bind=SUPER,j,focusdir,down

    # Alt+Tab overview
    bind=ALT,Tab,toggleoverview,

    # Move windows
    bind=SUPER+SHIFT,Left,exchange_client,left
    bind=SUPER+SHIFT,Right,exchange_client,right
    bind=SUPER+SHIFT,Up,exchange_client,up
    bind=SUPER+SHIFT,Down,exchange_client,down
    bind=SUPER+SHIFT,h,exchange_client,left
    bind=SUPER+SHIFT,l,exchange_client,right
    bind=SUPER+SHIFT,k,exchange_client,up
    bind=SUPER+SHIFT,j,exchange_client,down

    # Resize
    bind=CTRL+ALT,Up,resizewin,+0,-40
    bind=CTRL+ALT,Down,resizewin,+0,+40
    bind=CTRL+ALT,Left,resizewin,-40,+0
    bind=CTRL+ALT,Right,resizewin,+40,+0

    # Tags (workspaces)
    bind=SUPER,1,view,1,0
    bind=SUPER,2,view,2,0
    bind=SUPER,3,view,3,0
    bind=SUPER,4,view,4,0
    bind=SUPER,5,view,5,0
    bind=SUPER,6,view,6,0
    bind=SUPER,7,view,7,0
    bind=SUPER,8,view,8,0
    bind=SUPER,9,view,9,0

    # Move to tag
    bind=SUPER+SHIFT,1,tag,1,0
    bind=SUPER+SHIFT,2,tag,2,0
    bind=SUPER+SHIFT,3,tag,3,0
    bind=SUPER+SHIFT,4,tag,4,0
    bind=SUPER+SHIFT,5,tag,5,0
    bind=SUPER+SHIFT,6,tag,6,0
    bind=SUPER+SHIFT,7,tag,7,0
    bind=SUPER+SHIFT,8,tag,8,0
    bind=SUPER+SHIFT,9,tag,9,0

    # Next/prev workspace
    bind=SUPER,Home,viewtoleft_have_client,0
    bind=SUPER,End,viewtoright_have_client,0

    # Monitor
    bind=ALT+SHIFT,Left,focusmon,left
    bind=ALT+SHIFT,Right,focusmon,right

    # Scratchpad
    bind=SUPER,s,toggle_scratchpad

    # Screenshots
    bind=SUPER+SHIFT,p,spawn,hyprshot -m output
    bind=SUPER+SHIFT,r,spawn,hyprshot -m region
    bind=SUPER+SHIFT,w,spawn,hyprshot -m window

    # Lock
    bind=SUPER+SHIFT,x,spawn,hyprlock

    # Logout (kill compositor to return to SDDM)
    bind=SUPER+SHIFT,q,spawn,pkill -x mango

    # Switch layout
    bind=SUPER,n,switch_layout

    # Gaps
    bind=ALT+SHIFT,x,incgaps,1
    bind=ALT+SHIFT,z,incgaps,-1

    # Mouse bindings
    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=SUPER,btn_right,moveresize,curresize
    mousebind=NONE,btn_left,toggleoverview,-1

    # Scroll through workspaces
    axisbind=SUPER,UP,viewtoleft_have_client
    axisbind=SUPER,DOWN,viewtoright_have_client

    # Layer rules
    layerrule=animation_type_open:zoom,layer_name:rofi
    layerrule=animation_type_close:zoom,layer_name:rofi
  '';
}
