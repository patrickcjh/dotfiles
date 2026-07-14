shopt -s expand_aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias fgrep='fgrep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias egrep='egrep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias decolorize='sed "s/\x1B\[[0-9;]*[JKmsu]//g"'
alias gf='git fetchp'
alias gp='git pullp'
alias vimclean='find -iname "*.sw?" -delete'
alias cb='cargo build --color always 2>&1 | less -RC'
alias cl='cargo clippy --color always 2>&1 | less -RC'
alias cr='cargo run --color always 2>&1 | less -RC'
alias ct='cargo test --color always -- --show-output 2>&1 | less -RC'
alias cg='cargo playground --color always 2>&1 | less -RC'
alias cs='cargo sweep --time 1'
alias cs0='cargo sweep --time 0'
alias ce='cargo expand --lib'
alias ccc='cargo cache clean-unref && cargo cache clean-unref --dry-run && cargo cache clean-unref --dry-run'
alias scs='sccache --show-stats'
alias j='just'
alias evcxr='evcxr --edit-mode vi'
alias codex_upgrade='npm install --upgrade -g --prefix ~/.local @openai/codex'
alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"

dua() {
  local target="${1:-.}"
  local had_nullglob=0

  if shopt -q nullglob; then
    had_nullglob=1
  else
    shopt -s nullglob
  fi

  local paths=("$target"/.[!.]* "$target"/*)

  if [ "$had_nullglob" -eq 0 ]; then
    shopt -u nullglob
  fi

  if [ "${#paths[@]}" -eq 0 ]; then
    sudo du -sch -- "$target" | sort -h
  else
    sudo du -sch -- "${paths[@]}" | sort -h
  fi
}

gw() {
  if [ "$#" -eq 0 ]; then
    git worktree list
  else
    git worktree "$@"
  fi
}

gg() {
  local git_base gg_file line word
  local -a branches words

  git_base=$(git rev-parse --show-toplevel 2>/dev/null) || {
    git graph "$@"
    return
  }

  gg_file="$git_base/.gg"
  if [ ! -f "$gg_file" ]; then
    git graph "$@"
    return
  fi

  while IFS= read -r line; do
    line="${line%%#*}"
    [ -n "$line" ] || continue
    read -r -a words <<< "$line"
    for word in "${words[@]}"; do
      git rev-parse --verify --quiet "${word}^{commit}" >/dev/null || continue
      branches+=("$word")
    done
  done < "$gg_file"

  if [ "${#branches[@]}" -eq 0 ]; then
    git graph "$@"
    return
  fi

  git mlog --graph "${branches[@]}" "$@"
}
