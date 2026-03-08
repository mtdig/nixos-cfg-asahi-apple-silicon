{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 8;
        margin-top = 4;
        margin-left = 8;
        margin-right = 8;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "battery"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "󰲰";
            urgent = "";
            default = "󰧞";
          };
          on-click = "activate";
          sort-by-number = true;
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Chromium" = " $1";
            "(.*)- Visual Studio Code" = "󰨞 $1";
            "(.*)" = "$1";
          };
        };

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%A, %B %d, %Y  %H:%M:%S}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };

        battery = {
          bat = "macsmc-battery";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}\n{power:.1f}W";
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰈀 {ipaddr}";
          format-linked = "󰈀 No IP";
          format-disconnected = "󰤭  Disconnected";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          on-click = "blueman-manager";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂯 {volume}%";
          format-muted = "󰖁 Muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphone = "󰋋";
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 2;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(15, 26, 48, 0.85);
        color: #e8f0ff;
        border-radius: 12px;
        border: 1px solid rgba(126, 186, 228, 0.15);
      }

      tooltip {
        background: rgba(15, 26, 48, 0.95);
        border: 1px solid #7ebae4;
        border-radius: 8px;
        color: #e8f0ff;
      }

      #workspaces button {
        color: #5580aa;
        padding: 0 6px;
        border-radius: 8px;
        margin: 4px 2px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #7ebae4;
        background: rgba(126, 186, 228, 0.15);
      }

      #workspaces button.urgent {
        color: #f7768e;
        background: rgba(247, 118, 142, 0.15);
      }

      #workspaces button:hover {
        background: rgba(126, 186, 228, 0.1);
        color: #a0d0ff;
      }

      #window {
        color: #9ab8d7;
        padding: 0 12px;
      }

      #clock {
        color: #a0d0ff;
        font-weight: bold;
        padding: 0 12px;
      }

      #battery,
      #network,
      #bluetooth,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        color: #c8ddf5;
      }

      #battery.warning {
        color: #e0af68;
      }

      #battery.critical {
        color: #f7768e;
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to { color: #0f1a30; }
      }

      #network.disconnected {
        color: #f7768e;
      }

      #pulseaudio.muted {
        color: #5580aa;
      }

      #custom-power {
        color: #f7768e;
        padding: 0 12px 0 8px;
        font-size: 15px;
      }

      #custom-power:hover {
        color: #ff99a8;
      }
    '';
  };
}
