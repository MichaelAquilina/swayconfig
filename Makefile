install:
	rm -rf $$HOME/.config/sway
	ln -sf $$PWD/sway $$HOME/.config/sway
	rm -rf $$HOME/.config/rofi
	ln -sf $$PWD/rofi $$HOME/.config/rofi
	rm -rf $$HOME/.config/waybar
	ln -sf $$PWD/waybar $$HOME/.config/waybar
	rm -rf $$HOME/.config/mako
	ln -sf $$PWD/mako $$HOME/.config/mako
	rm -rf $$HOME/.config/swaylock
	ln -sf $$PWD/swaylock $$HOME/.config/swaylock
