install:
	rm -rf $$HOME/.config/sway
	ln -sf $$PWD/sway $$HOME/.config/sway
	rm -rf $$HOME/.config/rofi
	ln -sf $$PWD/rofi $$HOME/.config/rofi
	rm -rf $$HOME/.config/rofi-pass
	ln -sf $$PWD/rofi-pass $$HOME/.config/rofi-pass
	rm -rf $$HOME/.config/waybar
	ln -sf $$PWD/waybar $$HOME/.config/waybar
	rm -rf $$HOME/.config/mako
	ln -sf $$PWD/mako $$HOME/.config/mako
	rm -rf $$HOME/.config/swaylock
	ln -sf $$PWD/swaylock $$HOME/.config/swaylock
	ln -sf $$PWD/bin/playerbar.sh $$HOME/bin/playerbar.sh
	ln -sf $$PWD/bin/grim_wrapper.sh $$HOME/bin/grim_wrapper.sh
