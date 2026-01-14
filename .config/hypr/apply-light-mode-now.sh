#!/usr/bin/env bash
# Apply light mode settings now
echo "Applying light mode settings..."

# Run the enhanced light mode script
~/.config/hypr/scripts/LightMode.sh

# Also update Kvantum if you want (optional)
# kvantummanager --set "KvFlatLight" 2>/dev/null || true

echo "Light mode applied! Use Super+Shift+L for light mode, Super+Shift+D for dark mode"
echo "Note: Some applications may need to be restarted to see theme changes"
