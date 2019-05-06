install:
	rm -rf $$HOME/.config/sway
	ln -sf $$PWD/sway $$HOME/.config/sway
	rm -rf $$HOME/.config/rofi
	ln -sf $$PWD/rofi $$HOME/.config/rofi
	rm -rf $$HOME/.config/waybar
	ln -sf $$PWD/waybar $$HOME/.config/waybar
