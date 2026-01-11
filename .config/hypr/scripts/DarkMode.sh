#!/usr/bin/env bash
# Dark Mode Switch Script for Hyprland

# Set dark mode colors for Hyprland
hyprctl keyword general:col.active_border "rgba(33ccffee)"
hyprctl keyword general:col.inactive_border "rgba(595959aa)"
hyprctl keyword group:col.border_active "rgba(33ccffee)"
hyprctl keyword group:groupbar:col.active "rgba(333333aa)"

# Set GTK dark mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme 'Flat-Remix-GTK-Blue-Dark' 2>/dev/null || true

# For NixOS
if [ -n "$(grep -i nixos < /etc/os-release 2>/dev/null)" ]; then
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 2>/dev/null || true
    dconf write /org/gnome/desktop/interface/gtk-theme "'Flat-Remix-GTK-Blue-Dark'" 2>/dev/null || true
fi

# Notify user
notify-send -t 3000 "Dark Mode" "Switched to dark theme"