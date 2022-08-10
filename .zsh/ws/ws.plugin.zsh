# ws command
ws () {
  help() {
    echo 'Usage: ws <subcommand>'
    echo
    echo 'Subcommands:'
    echo '  git, provision'
  }

  die() {
    echo "$@" >&2
    help
  }

  cmd_provision () {
    cd $HOME/.provision
    ansible-playbook playbook.yml -i hosts --tags="$1"
    rake serverspec:$1
    cd -
  }

  cmd_git () {
    git --git-dir=$HOME/macOS/ --work-tree=$HOME "$@"
  }

  err_not_found () {
    die "ws: invalid subcommand $1"
  }

  case "$1" in
    -h|--help) help ;;
    provision) shift; cmd_provision "$@" ;;
    git) shift; cmd_git "$@" ;;
    *) err_not_found "$@" ;;
  esac
}
