{ pkgs, config, ... }:

{
  home.file.".config/conky/conky.conf".text = ''
    conky.config = {
        own_window = true,
        own_window_class = 'Conky',
        own_window_type = 'override',
        own_window_transparent = false,
        own_window_argb_visual = true,
        own_window_argb_value = 160,
        own_window_colour = '0f1a30',
        own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

        alignment = 'top_right',
        gap_x = 20,
        gap_y = 40,
        minimum_width = 260,
        maximum_width = 260,
        minimum_height = 5,

        border_width = 0,
        draw_borders = false,
        draw_outline = false,
        draw_shades = false,
        draw_graph_borders = false,
        stippled_borders = 0,
        border_inner_margin = 16,
        border_outer_margin = 0,

        use_xft = true,
        font = 'JetBrainsMono Nerd Font:size=10',
        xftalpha = 1.0,
        override_utf8_locale = true,
        default_color = 'c8ddf5',
        color1 = 'a0d0ff',
        color2 = 'b0d8ff',
        color3 = '90dce8',
        color4 = '5580aa',
        color5 = 'e8f0ff',
        color6 = 'f7768e',

        background = true,
        cpu_avg_samples = 4,
        net_avg_samples = 2,
        double_buffer = true,
        no_buffers = true,
        out_to_wayland = true,
        out_to_x = false,
        text_buffer_size = 2048,
        update_interval = 3.0,
        imlib_cache_size = 0,
        total_run_times = 0,
    };

    conky.text = [[
    ''${font JetBrainsMono Nerd Font:bold:size=11}''${color1}  NixOS''${font}''${color}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}SYSTEM''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color5}''${nodename}''${alignr}''${color}''${sysname} ''${kernel}
    ''${color5}Uptime''${alignr}''${color}''${uptime_short}
    ''${color5}Processes''${alignr}''${color}''${processes} (''${running_processes} running)''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}BATTERY''${alignr}''${color3}''${cat /sys/class/power_supply/macsmc-battery/capacity}%''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color5}Status''${alignr}''${color}''${cat /sys/class/power_supply/macsmc-battery/status}
    ''${color5}Health''${alignr}''${color}''${cat /sys/class/power_supply/macsmc-battery/health}''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}CPU''${alignr}''${color3}''${cpu}%''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color4}''${cpubar 4}''${color}
    ''${color5}Core 0''${alignr}''${color}''${cpu cpu1}%
    ''${color5}Core 1''${alignr}''${color}''${cpu cpu2}%
    ''${color5}Core 2''${alignr}''${color}''${cpu cpu3}%
    ''${color5}Core 3''${alignr}''${color}''${cpu cpu4}%
    ''${color5}Core 4''${alignr}''${color}''${cpu cpu5}%
    ''${color5}Core 5''${alignr}''${color}''${cpu cpu6}%
    ''${color5}Core 6''${alignr}''${color}''${cpu cpu7}%
    ''${color5}Core 7''${alignr}''${color}''${cpu cpu8}%
    ''${color5}Freq''${alignr}''${color}''${freq_g}GHz
    ''${color5}Temp''${alignr}''${color}''${acpitemp}°C''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}MEMORY''${alignr}''${color3}''${memperc}%''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color4}''${membar 4}''${color}
    ''${color5}Used''${alignr}''${color}''${mem} / ''${memmax}
    ''${color5}Swap''${alignr}''${color}''${swap} / ''${swapmax}''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}STORAGE''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color5}/''${alignr}''${color}''${fs_used /} / ''${fs_size /}
    ''${color4}''${fs_bar 4 /}''${color}
    ''${color5}Read: ''${color}''${diskio_read}''${alignr}''${color5}Write: ''${color}''${diskio_write}''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}NETWORK''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${if_existing /sys/class/net/wlan0/operstate up}''${color5}wlan0''${alignr}''${color}''${addr wlan0}
    ''${color5} Up: ''${color}''${upspeed wlan0}''${alignr}''${color5} Dn: ''${color}''${downspeed wlan0}''${endif}
    ''${if_existing /sys/class/net/eth0/operstate up}''${color5}eth0''${alignr}''${color}''${addr eth0}
    ''${color5} Up: ''${color}''${upspeed eth0}''${alignr}''${color5} Dn: ''${color}''${downspeed eth0}''${endif}
    ''${if_existing /sys/class/net/enp0s1/operstate up}''${color5}enp0s1''${alignr}''${color}''${addr enp0s1}
    ''${color5} Up: ''${color}''${upspeed enp0s1}''${alignr}''${color5} Dn: ''${color}''${downspeed enp0s1}''${endif}''${font}
    ''${color4}''${hr 1}''${color}
    ''${voffset 4}''${color2}TOP  CPU''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color5}''${top name 1}''${alignr}''${color3}''${top cpu 1}%
    ''${color5}''${top name 2}''${alignr}''${color}''${top cpu 2}%
    ''${color5}''${top name 3}''${alignr}''${color}''${top cpu 3}%
    ''${voffset 4}''${color2}''${font JetBrainsMono Nerd Font:size=9}TOP  MEM''${color}''${font JetBrainsMono Nerd Font:size=8}
    ''${color5}''${top_mem name 1}''${alignr}''${color3}''${top_mem mem_res 1}
    ''${color5}''${top_mem name 2}''${alignr}''${color}''${top_mem mem_res 2}
    ''${color5}''${top_mem name 3}''${alignr}''${color}''${top_mem mem_res 3}''${font}
    ]];
  '';

  home.file.".config/autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Conky
    Exec=${pkgs.conky}/bin/conky -c ${config.home.homeDirectory}/.config/conky/conky.conf --daemonize --pause=3
    StartupNotify=false
    X-KDE-autostart-phase=2
  '';
}
