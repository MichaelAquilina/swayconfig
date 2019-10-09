install:
	rm -rf $$HOME/.config/sway
	ln -sf $$PWD/sway $$HOME/.config/sway
	rm -rf $$HOME/.config/waybar
	ln -sf $$PWD/waybar $$HOME/.config/waybar
	rm -rf $$HOME/.config/mako
	ln -sf $$PWD/mako $$HOME/.config/mako
	rm -rf $$HOME/.config/swaylock
	ln -sf $$PWD/swaylock $$HOME/.config/swaylock
	rm -rf $$HOME/.config/swaynag
	ln -sf $$PWD/swaynag $$HOME/.config/swaynag
	rm -rf $$HOME/.config/kitty
	ln -sf $$PWD/kitty $$HOME/.config/kitty
	rm -rf $$HOME/.config/kanshi
	ln -sf $$PWD/kanshi $$HOME/.config/kanshi
	ln -sf $$PWD/backgrounds $$HOME/backgrounds
	ln -sf $$PWD/bin/playerbar.sh $$HOME/bin/playerbar.sh
	ln -sf $$PWD/bin/grim_wrapper.sh $$HOME/bin/grim_wrapper.sh
	ln -sf $$PWD/bin/recorder_wrapper.sh $$HOME/bin/recorder_wrapper.sh
	ln -sf $$PWD/bin/sway-power.sh $$HOME/bin/sway-power.sh
	ln -sf $$PWD/bin/lofi.sh $$HOME/bin/lofi.sh
	ln -sf $$PWD/bin/git_project.sh $$HOME/bin/git_project.sh
	ln -sf $$PWD/bin/desktop_search.py $$HOME/bin/desktop_search.py
	ln -sf $$PWD/zshrc $$HOME/.zshrc
	ln -sf $$PWD/tigrc $$HOME/.tigrc
	ln -sf $$PWD/nvim/init.vim $$HOME/.config/nvim/init.vim
	ln -sf $$PWD/dircolors $$HOME/.dircolors
	ln -sf $$PWD/applications/firefox-wayland.desktop $$HOME/.local/share/applications/firefox-wayland.desktop
