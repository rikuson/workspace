# space command
space () {
  help() {
    echo 'Usage: space <subcommand>'
    echo
    echo 'Subcommands:'
    echo '  git, provision, test'
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
    git --git-dir=$HOME/workspace/ --work-tree=$HOME "$@"
  }

  cmd_test () {
    cd $HOME/.provision
    rake serverspec:$1
    cd -
  }

  err_not_found () {
    die "space: invalid subcommand $1"
  }

  case "$1" in
    -h|--help) help ;;
    provision) shift; cmd_provision "$@" ;;
    test) shift; cmd_test "$@" ;;
    git) shift; cmd_git "$@" ;;
    *) err_not_found "$@" ;;
  esac
}
