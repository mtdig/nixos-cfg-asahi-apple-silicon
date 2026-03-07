{ ... }:

{
  home.file.".config/ghostty/config".text = ''
    shell-integration = bash 
    font-family = JetBrainsMono Nerd Font
    font-size = 10
    theme = Dracula
    mouse-hide-while-typing = true
    scrollback-limit = 100000000
    gtk-single-instance = false


    keybind = ctrl+n=new_window

    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard

    keybind = ctrl+h=goto_split:left
    keybind = ctrl+j=goto_split:bottom
    keybind = ctrl+k=goto_split:top
    keybind = ctrl+l=goto_split:right

    keybind = ctrl+shift+k=clear_screen

    keybind = ctrl+a>h=new_split:left
    keybind = ctrl+a>j=new_split:down
    keybind = ctrl+a>k=new_split:up
    keybind = ctrl+a>l=new_split:right
    keybind = ctrl+a>f=toggle_split_zoom

    keybind = ctrl+a>n=next_tab
    keybind = ctrl+a>p=previous_tab

    keybind = super+r=reload_config

    window-save-state = always
    background-opacity = 0.95
    maximize = true

  '';
}
