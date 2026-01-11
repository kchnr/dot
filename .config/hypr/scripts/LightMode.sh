#!/usr/bin/env bash
# Light Mode Switch Script for Hyprland

# Set light mode colors for Hyprland
hyprctl keyword general:col.active_border "rgba(0066ffee)"
hyprctl keyword general:col.inactive_border "rgba(ccccccaa)"
hyprctl keyword group:col.border_active "rgba(0066ffee)"
hyprctl keyword group:groupbar:col.active "rgba(eeeeeeaa)"

# Set GTK light mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme 'Flat-Remix-GTK-Blue-Light' 2>/dev/null || true

# For NixOS
if [ -n "$(grep -i nixos < /etc/os-release 2>/dev/null)" ]; then
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/gtk-theme "'Flat-Remix-GTK-Blue-Light'" 2>/dev/null || true
fi

# Notify user
notify-send -t 3000 "Light Mode" "Switched to light theme"