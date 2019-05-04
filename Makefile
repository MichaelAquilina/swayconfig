install:
	mkdir -p $$HOME/.config/sway
	mkdir -p $$HOME/.config/swaylock
	mkdir -p $$HOME/.config/waybar
	mkdir -p $$HOME/.config/rofi/
	ln -sf $$PWD/sway $$HOME/.config/sway/config
	ln -sf $$PWD/rofi $$HOME/.config/rofi/config
	ln -sf $$PWD/waybar $$HOME/.config/waybar/config
