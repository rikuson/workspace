#compdef space

_space () {
	local cmd
	if (( CURRENT > 2)); then
		(( CURRENT-- ))
		cmd=${words[$CURRENT]}
		case "${cmd}" in
      add)
        local -a subcommands
        _values -C \
          'unstaged files' \
          $(git --git-dir=$HOME/workspace/ --work-tree=$HOME status --porcelain | awk '{print $2}')
        ;;
      checkout)
        local -a subcommands
        _values -C \
          'branches' \
          $(git --git-dir=$HOME/workspace/ --work-tree=$HOME for-each-ref --format='%(refname:short)' refs/heads/)
        ;;
			git)
				local -a subcommands
				subcommands=(
					"add:Add files to staging area"
          "checkout:Checkout branch"
					"config:Show git config"
					"init:Initialize git repository"
					"log:Show git log"
					"pull:Pull from remote repository"
					"push:Push to remote repository"
					"reflog:Show git reflog"
          "commit:Commit staged files"
				)
				_describe -t commands 'space git' subcommands
				;;
			provision)
				local -a subcommands
				subcommands=(
					"appstore:Provision appstore tools"
					"cui:Provision cui tools"
					"gui:Provision gui tools"
					"os:Provision os settings"
				)
				_describe -t commands 'space provision' subcommands
				;;
      *)
        ;;
		esac
	else
    local -a subcommands
    subcommands=(
      "git:Git command targetting config repository."
      "provision:Run ansible-playbook and serverspec."
    )
    _describe -t commands 'space' subcommands
	fi
}

compdef _space space
