#compdef ws

_ws () {
  _values \
    'subcommand' \
    'git[Git command targetting config repository.]' \
    'provision[Run ansible-playbook and serverspec.]'
}

compdef _ws ws
