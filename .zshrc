
alias cdr='cd ~/Documents/Projects'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/';
}

# RPROMPT GIT
# autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
#zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'

# PROMPT='%(?.%F{green}√.%F{red}?%?)%f %n@%m:%B%F{blue}%~%f%b %F{red}$(parse_git_branch)%f %# '
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{blue}%~%f%b %F{red}$(parse_git_branch)%f %(!.#.$) '
