# Path to your oh-my-zsh installation.
export ZSH=/Users/sahil/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails ruby brew bundler capistrano github git-hubflow heroku sbt scala sudo tmux)

# User configuration

export PATH="/Users/sahil/.rvm/gems/ruby-2.1.4/bin:/Users/sahil/.rvm/gems/ruby-2.1.4@global/bin:/Users/sahil/.rvm/rubies/ruby-2.1.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sahil/.rvm/bin:/Users/sahil/activator-1.3.6-minimal"
# export MANPATH="/usr/local/man:$MANPATH"
#export PATH="$PATH:$HOME/.rvm/gems/ruby-2.1.4/bin/"
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias mux="tmuxinator"
alias rubytest="bundle exec testrbl -I test"
source ~/source/tmuxinator/completion/tmuxinator.zsh

sbt-dependency-graph() {
  SBT_DEPENDENCY_OUT=`mktemp -t sbt_dependency`
  sbt dependencyDot | tee "$SBT_DEPENDENCY_OUT"
  DOT_FILE_PATH=`sed -n 's/.*Wrote dependency graph to '"'"'\(.*\)'"'"'.*/\1/p' "$SBT_DEPENDENCY_OUT"`
  rm "$SBT_DEPENDENCY_OUT"
  PD_DOT_FILE_PATH=`echo "$DOT_FILE_PATH" | sed 's/\.dot$/.pd.dot/'`
  ~/scripts/format-deps-graph.rb "$DOT_FILE_PATH" >"$PD_DOT_FILE_PATH"
  echo "Wrote PagerDuty library graph to file: $PD_DOT_FILE_PATH"
  PD_IMG_FILE_PATH=`echo "$PD_DOT_FILE_PATH" | sed 's/\.pd.dot$/.png/'`
  cat $PD_DOT_FILE_PATH | dot -Tpng > "$PD_IMG_FILE_PATH"
  open -a Preview "$PD_IMG_FILE_PATH"
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
