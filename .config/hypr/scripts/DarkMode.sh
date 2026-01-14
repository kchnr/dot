#!/usr/bin/env bash
# Dark Mode Switch Script for Hyprland

# Set dark mode colors for Hyprland
hyprctl keyword general:col.active_border "rgba(33ccffee)"
hyprctl keyword general:col.inactive_border "rgba(595959aa)"
hyprctl keyword group:col.border_active "rgba(33ccffee)"
hyprctl keyword group:groupbar:col.active "rgba(333333aa)"

# Set GTK dark mode
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark" 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true

# For NixOS
if [ -n "$(grep -i nixos < /etc/os-release 2>/dev/null)" ]; then
    dconf write /org/gnome/desktop/interface/color-scheme "\"prefer-dark\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/gtk-theme "\"Flat-Remix-GTK-Blue-Dark\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/icon-theme "\"Flat-Remix-Blue-Dark\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/cursor-theme "\"Bibata-Modern-Ice\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/cursor-size "24" 2>/dev/null || true
fi

# Set Kvantum theme for Qt apps (dark mode)
if [ -f "/usr/share/Kvantum/catppuccin-mocha-blue/catppuccin-mocha-blue.kvconfig" ]; then
    mkdir -p ~/.config/Kvantum
    cp -r /usr/share/Kvantum/catppuccin-mocha-blue ~/.config/Kvantum/ 2>/dev/null || true
    echo "kvantum_theme=catppuccin-mocha-blue" > ~/.config/Kvantum/kvantum.kvconfig 2>/dev/null || true
    echo "Kvantum theme set to catppuccin-mocha-blue (dark)"
else
    echo "Note: catppuccin-mocha-blue Kvantum theme not found."
fi

# Set Qt5/Qt6 configuration
if [ -f ~/.config/qt5ct/qt5ct.conf ]; then
    sed -i 's|^style=.*|style=kvantum|' ~/.config/qt5ct/qt5ct.conf
    sed -i 's|^icon_theme=.*|icon_theme=Flat-Remix-Blue-Dark|' ~/.config/qt5ct/qt5ct.conf
fi

if [ -f ~/.config/qt6ct/qt6ct.conf ]; then
    sed -i 's|^style=.*|style=kvantum|' ~/.config/qt6ct/qt6ct.conf
    sed -i 's|^icon_theme=.*|icon_theme=Flat-Remix-Blue-Dark|' ~/.config/qt6ct/qt6ct.conf
fi

# Notify user
notify-send -t 3000 "Dark Mode" "Switched to dark theme (GTK, Icons, Qt)"
