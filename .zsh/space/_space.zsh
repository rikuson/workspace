#compdef space

_space () {
  _values \
    'subcommand' \
    'git[Git command targetting config repository.]' \
    'provision[Run ansible-playbook and serverspec.]'
}

compdef _space space
