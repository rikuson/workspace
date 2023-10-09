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
