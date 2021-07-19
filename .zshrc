# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/bmartin/.oh-my-zsh
export DCS_RC=`cat ~/.dcs-rc`
export FEM_RC=`cat ~/.fem-rc`
export CURRENT_BRANCHES='~/.current_branches'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="bureau"
ZSH_THEME="fino"
ZSH_THEME="cloud"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

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
plugins=(
    git django docker gcloud 
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm



export PATH=/Users/bmartin/Tools/bin:$PATH
export PATH=/Users/bmartin/Library/Python/3.9/bin:$PATH
. /Users/bmartin/Tools/z/z.sh
export PATH=/usr/local/bin:$PATH

#function setupSTS {
#  AWS_PROFILE=bastion-no-sts aws sts get-session-token --serial-number arn:aws:iam::254553705505:mfa/bmartin  --token-code $1
#}


export EDITOR=vim

function bgrep {
    grep -r $1 $2/**/*.$3
}

function how2ResetStaging {
CAT <<FOO
    git fetch origin
    git reset --hard origin/master
FOO
}

function how2S3Commands {
cat <<FOO
aws2 s3 rm s3://pmd-thelab-dcs-static-files/latest  --recursive --profile django-build-user
FOO
}

function help-ssl-localhost {
echo <<FOO
    chrome://flags/#allow-insecure-localhost
    https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate
FOO
}

function openDevSite {
    branch=`git rev-parse --abbrev-ref HEAD`

    if [ "$1" != "" ]; then
        branch=$1
    fi
    open https://dcs-${branch}-ottawacitizen.dev.postmedia.digital/
}

function getBranch {
    git checkout --track -b $1 origin/$1
}

function cc_list_indexes()
{
    if [ "$1" = "dev" ] 
    then
        curl -X GET http://dev-content-search.internal.dev.postmedia.digital/_cat/indices?v&s=index
    else
        curl -X GET http://localhost:9200/_cat/indices
    fi
}

function cc_saveBranch()
{
    if [ "$1" = "" ]; then
        branch=`git rev-parse --abbrev-ref HEAD`
    else
        branch=$1
    fi

    echo $branch >> ~/.current_branches
    cat ~/.current_branches | sort | uniq > ~/.tmp-branches
    cp ~/.tmp-branches ~/.current_branches
}
function cc_branches()
{
    cat ~/.current_branches
}

function jira() {
    open https://postmediadigital.atlassian.net/browse/$1
}

function build_fem() {
  open "https://jenkins.dev.postmedia.digital/job/Frontend%20Modules%20Jobs/job/frontend_snapshots_build/build?delay=0sec"
}

# capture ovverride for current fem branch and send it to tty and clipboard
function override_url()
{
    commit=`git log --pretty=format:'%h' -n 1`
    branch=`git rev-parse --abbrev-ref HEAD`
    override_url="?fem_override=${branch}-${commit}"
    echo $override_url
    echo $override_url | pbcopy
}

# Use ~~ as the trigger sequence instead of the default **
 export FZF_COMPLETION_TRIGGER='**'
#
# # Options to fzf command
 export FZF_COMPLETION_OPTS='+c -x'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ $TMUX = "" ]] && export TERM="xterm-256color"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh

# export PYTHONSTARTUP=/Users/bmartin/Tools/scripts/startup.py

unsetopt correct_all

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

function d_delete_by_tag {
    tag=$1
    img_id=`docker image ls | grep mylatest | awk -F" " '{ print $3}'`
    docker image rm -f $img_id
}

function d_shell_by_tag {
    docker run -it $1 /bin/sh -login
}

function d_i_ls {
    docker image ls
}


# --  home dev helpers 
function  download_dev_pdf  {
    aws s3 cp s3://dmh-reports/development/$1 ~/Desktop
}
function  copy_to_dev {
    scp -i ~/.home.ssh/id_rsa $1 $CURRENT_DEV:.
}
function  exportdev {
    export CURRENT_DEV=$1
    echo $CURRENT_DEV >  ~/.current_dev
}
function sshdev {
    ssh -i ~/.home.ssh/id_rsa $CURRENT_DEV
    
}

function openm20 {
    open  http://$CURRENT_DEV:8080
}

alias wiki='ssh -F ~/.home.ssh/config -i ~/.home.ssh/id_rsa  wiki'
alias personaldev='ssh -i ~/.home.ssh/id_rsa' 
alias milk='ssh -F ~/.home.ssh/config -i  ~/.home.ssh/id_rsa  MilkApp'

# -- end of  personal dev




# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bmartin/Tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bmartin/Tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bmartin/Tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bmartin/Tools/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=/Users/bmartin/.config/gcloud/application_default_credentials.json
