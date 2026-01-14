#!/usr/bin/env bash
# Light Mode Switch Script for Hyprland

# Set light mode colors for Hyprland
hyprctl keyword general:col.active_border "rgba(0066ffee)"
hyprctl keyword general:col.inactive_border "rgba(ccccccaa)"
hyprctl keyword group:col.border_active "rgba(0066ffee)"
hyprctl keyword group:groupbar:col.active "rgba(eeeeeeaa)"

# Set GTK light mode
gsettings set org.gnome.desktop.interface color-scheme "prefer-light" 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Light" 2>/dev/null || true
gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Light" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true

# For NixOS
if [ -n "$(grep -i nixos < /etc/os-release 2>/dev/null)" ]; then
    dconf write /org/gnome/desktop/interface/color-scheme "\"prefer-light\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/gtk-theme "\"Flat-Remix-GTK-Blue-Light\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/icon-theme "\"Flat-Remix-Blue-Light\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/cursor-theme "\"Bibata-Modern-Ice\"" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/cursor-size "24" 2>/dev/null || true
fi

# Set Kvantum theme for Qt apps (light mode)
# First try to set it directly, if that opens GUI, use config file method
if [ -f "/usr/share/Kvantum/catppuccin-latte-blue/catppuccin-latte-blue.kvconfig" ]; then
    # Method 1: Direct config file copy
    mkdir -p ~/.config/Kvantum
    cp -r /usr/share/Kvantum/catppuccin-latte-blue ~/.config/Kvantum/ 2>/dev/null || true
    echo "kvantum_theme=catppuccin-latte-blue" > ~/.config/Kvantum/kvantum.kvconfig 2>/dev/null || true
    echo "Kvantum theme set to catppuccin-latte-blue (light)"
else
    echo "Note: catppuccin-latte-blue Kvantum theme not found. Qt apps may stay dark."
    echo "Available light Kvantum themes:"
    find /usr/share/Kvantum -name "*latte*" -o -name "*light*" -type d 2>/dev/null | head -5
fi

# Set Qt5/Qt6 configuration
if [ -f ~/.config/qt5ct/qt5ct.conf ]; then
    sed -i 's|^style=.*|style=kvantum|' ~/.config/qt5ct/qt5ct.conf
    sed -i 's|^icon_theme=.*|icon_theme=Flat-Remix-Blue-Light|' ~/.config/qt5ct/qt5ct.conf
fi

if [ -f ~/.config/qt6ct/qt6ct.conf ]; then
    sed -i 's|^style=.*|style=kvantum|' ~/.config/qt6ct/qt6ct.conf
    sed -i 's|^icon_theme=.*|icon_theme=Flat-Remix-Blue-Light|' ~/.config/qt6ct/qt6ct.conf
fi

# Notify user
notify-send -t 3000 "Light Mode" "Switched to light theme (GTK, Icons, Qt)"
