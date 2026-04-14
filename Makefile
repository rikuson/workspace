all:
	ansible-playbook playbook.yml -i hosts
cui:
	ansible-playbook playbook.yml -i hosts --tags="cui"
gui:
	ansible-playbook playbook.yml -i hosts --tags="gui"
appstore:
	ansible-playbook playbook.yml -i hosts --tags="appstore"
os:
	ansible-playbook playbook.yml -i hosts --tags="os"
sync:
	jinja2 roles/cui/templates/.config/lazygit/config.yml -o ~/.config/lazygit/config.yml
	jinja2 roles/cui/templates/.config/nvim/init.lua -o ~/.config/nvim/init.lua
	rsync -av --delete roles/cui/templates/.config/nvim/lua/ ~/.config/nvim/lua/
test:
	rake serverspec:all
