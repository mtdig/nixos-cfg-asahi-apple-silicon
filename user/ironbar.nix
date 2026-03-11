{ pkgs, ... }:

{
  # Ironbar config — used on Hyprland & MangoWC instead of conky
  home.file.".config/ironbar/config.json".text = builtins.toJSON {
    position = "top";
    height = 38;
    margin.top = 4;
    margin.left = 8;
    margin.right = 8;
    icon_theme = "Papirus-Dark";

    start = [
      {
        type = "workspaces";
        name_map = {
          "1" = "󰲠";
          "2" = "󰲢";
          "3" = "󰲤";
          "4" = "󰲦";
          "5" = "󰲨";
          "6" = "󰲪";
          "7" = "󰲬";
          "8" = "󰲮";
          "9" = "󰲰";
        };
        all_monitors = false;
      }
      {
        type = "focused";
        show_icon = true;
        show_title = true;
        truncate.mode = "end";
        truncate.length = 40;
      }
    ];

    center = [
      {
        type = "clock";
        format = "  %H:%M";
        format_popup = "%A, %B %d, %Y  %H:%M:%S";
      }
    ];

    end = [
      {
        type = "sys_info";
        format = [
          "  {cpu_percent@mean}%"
          "  {memory_used#Gi:.1}Gi / {memory_total#Gi:.1}Gi"
          "  {disk_used@/#Gi:.0}Gi / {disk_total@/#Gi:.0}Gi"
          " {temp_c@max:.0}°C"
        ];
        interval = {
          cpu = 3;
          memory = 5;
          temps = 10;
          disks = 30;
        };
      }
      {
        type = "volume";
        format = "{icon} {percentage}%";
        max_volume = 150;
        icons = {
          volume_high = "󰕾";
          volume_medium = "󰖀";
          volume_low = "󰕿";
          muted = "󰖁";
        };
        on_click_right = "pavucontrol";
      }
      {
        type = "battery";
        format = "{percentage}%";
      }
      {
        type = "script";
        name = "brightness";
        cmd = "echo \"󰃠 $(brightnessctl -m | cut -d, -f4)\"";
        mode = "poll";
        interval = 3000;
        on_click_left = "brightnessctl set +5%";
        on_click_right = "brightnessctl set 5%-";
      }
      {
        type = "tray";
      }
      {
        type = "clock";
        name = "date-compact";
        format = "  %d/%m";
      }
      {
        type = "custom";
        name = "power-btn";
        bar = [
          {
            type = "button";
            label = "⏻";
            name = "power-button";
            on_click = "!wlogout";
          }
        ];
      }
    ];
  };

  home.file.".config/ironbar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 13px;
      color: #e8f0ff;
    }

    /* Force all GTK widgets transparent */
    button, scale, image, box, label {
      background: transparent;
      background-color: transparent;
      background-image: none;
      border: none;
      box-shadow: none;
      min-height: 0;
      min-width: 0;
      padding: 0;
      margin: 0;
    }

    .background {
      background: rgba(15, 26, 48, 0.88);
      border-radius: 12px;
      border: 1px solid rgba(126, 186, 228, 0.15);
    }

    /* ── Workspaces ── */
    .workspaces .item {
      color: #5580aa;
      padding: 0 6px;
      margin: 4px 2px;
      border-radius: 8px;
      transition: all 200ms ease;
    }

    .workspaces .item.focused {
      color: #7ebae4;
      background: rgba(126, 186, 228, 0.15);
    }

    .workspaces .item:hover {
      color: #a0d0ff;
      background: rgba(126, 186, 228, 0.1);
    }

    /* ── Focused window ── */
    .focused {
      color: #9ab8d7;
      padding: 0 12px;
    }

    /* ── Clock ── */
    .clock {
      color: #a0d0ff;
      font-weight: bold;
      padding: 0 12px;
    }

    #date-compact {
      font-weight: normal;
      color: #c8ddf5;
    }

    /* ── Sys Info ── */
    .sysinfo {
      padding: 0 4px;
    }

    .sysinfo .item {
      color: #c8ddf5;
      padding: 0 8px;
    }

    /* ── Network ── */
    .network_manager {
      padding: 0 8px;
      color: #c8ddf5;
    }

    /* ── Bluetooth ── */
    .bluetooth {
      padding: 0 8px;
      color: #c8ddf5;
    }

    /* ── Volume ── */
    .volume {
      padding: 0 8px;
      color: #c8ddf5;
    }

    /* ── Battery ── */
    .battery {
      padding: 0 8px;
      color: #c8ddf5;
    }

    /* ── Tray ── */
    .tray {
      padding: 0 4px;
    }

    /* ── Power button ── */
    #power-button {
      color: #f7768e;
      padding: 0 8px;
      font-size: 15px;
    }

    #power-button:hover {
      color: #ff99a8;
    }

    /* ── Popups ── */
    .popup {
      background: rgba(15, 26, 48, 0.95);
      border: 1px solid #7ebae4;
      border-radius: 10px;
      padding: 8px;
    }

    .popup label {
      color: #e8f0ff;
    }

    /* ── Tooltips ── */
    tooltip {
      background: rgba(15, 26, 48, 0.95);
      border: 1px solid #7ebae4;
      border-radius: 8px;
    }

    tooltip label {
      color: #e8f0ff;
    }
  '';
}
