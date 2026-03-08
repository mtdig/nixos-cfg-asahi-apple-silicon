{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdotool
  ];

  # Rofi launcher shortcut (Alt+Space)
  home.file.".config/khotkeysrc".text = ''
    [Data]
    DataCount=1

    [Data_1]
    Comment=Launch Rofi
    Enabled=true
    Name=Launch Rofi
    Type=SIMPLE_ACTION_DATA

    [Data_1Actions]
    ActionsCount=1

    [Data_1Actions0]
    CommandURL=rofi -show drun
    Type=COMMAND_URL

    [Data_1Conditions]
    Comment=
    ConditionsCount=0

    [Data_1Triggers]
    Comment=
    TriggersCount=1

    [Data_1Triggers0]
    Key=Alt+Space
    Type=SHORTCUT
    Uuid={d49b3e5a-7f12-4b3a-9c8d-1a2e3f4b5c6d}
  '';
}
