###########
# GENERAL #
###########

# make bash autocomplete with up arrow
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
alias home='cd ~'
alias ..='cd ..' # move up 1 dir
alias ...='cd ../..' # move up 2 dirs
alias rr="cd ~/web/rails/repos" # open root project directory
alias cl="clear"
alias cll="clear; ls"
alias ffp="Firefox.app/Contents/MacOS/firefox -no-remote -P"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'


# get a history of top commands used sorted by usage
alias hstat="history |
awk '{a[\$2]++}END{for(i in a){print a[i] \" \" i}}' |
sort -rn |
head"

function cdrr {
  cd ~/web/rails/repos; 
  if [ "$1" ]; then
    cd `ls|grep $1|sort|tail -1`
  fi
}

function cdpr {
  cd ~/proj/repos; 
  if [ "$1" ]; then
    cd `ls|grep $1|sort|tail -1`
  fi
}

function cdkr {
  cd ~/proj/katas; 
  if [ "$1" ]; then
    cd `ls|grep $1|sort|tail -1`
  fi
}


# Project aliases
alias cdd='cdpr docvia-web-ruby'


function take {
  mkdir $1
  cd $1
}

# change the title of the terminal window
function title {
  echo -n -e "\033]0;$1\007"
}


###########
# TEXTMATE #
###########
alias m.="mate . &" # open current dir
alias m.r="mate app config lib db jobs public test spec features vendor/plugins &" # open current dir assuming rails


########
# RUBY #
########
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems by default for irb
# really awesome function, use: cdgem <gem name>, cd's into your gems directory and opens gem that best matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}


#########
# RAILS #
#########
# alias ss="./script/server"
alias sc="./script/console"
alias sg="./script/generate"
alias sp="./script/plugin"
alias a='autotest'
alias aw="watchr ~/.watchr/test.watchr"
alias rmig="rake db:migrate db:test:prepare"
alias dierails='ps -a|grep "ruby ./script/server"|grep -v "grep"|cut -d " " -f1|xargs -n 1 kill -TERM'

# ss - A better script/server alias.
# Usage:
#   ss <my_rails_app>
# Will 
#   - cd to the project directory (if argument provided, otherwise will use current directory)
#   - kill any existing rails server instances
#   - start the rails server
function ss {
  if [ "$1" ]; then
    # cd to the rails app directory.
    cd ~/proj/repos;  # (update the repository root location to suit your needs)
    if [ "$1" ]; then
      cd `ls|grep $1|sort|tail -1`
    fi
    echo $(pwd)
  fi
  # kill any existing rails server processes.
  ps -a|grep "ruby ./script/server"|grep -v "grep"|cut -d " " -f1|xargs -n 1 kill -TERM
  
  # start the server.
  ruby ./script/server
}

function trails {
  rails $1
  cd $1
  m.r
}



# cf - Run cucumber features
# Usage:
#   cf [feature][:line number]
#
# Examples:
#   cf                          (run all features)
#   cf my_feature               (run cucumber for my_feature)
#   cf my_feature.feature       (run cucumber for my_feature)
#   cf my_feature:22            (run the cucumber scenario for my_feature at line 22)
#   cf my_feature.feature:22    (run the cucumber scenario for my_feature at line 22)
function cf {
  if [ "$1" ]; then
    pattern='.*\(\:.*\)'
    
    nl=${1/.feature/}
    line=`expr "$nl" : "$pattern"`
    path=${nl%%$line}
    name=${path/features\//}
    
    cucumber features/"$name".feature"$line"
  else
    cucumber features
  fi
}

#######
# SVN #
#######
alias svnclear='find . -name .svn -print0 | xargs -0 rm -rf' # removes all .svn folders from directory recursively
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add' # adds all unadded files
alias svnrmall='svn status | grep "^\!" | awk "{print \$2}" | xargs svn rm' # removes all deleted files

#######
# git #
#######
alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff'

# gc      => git checkout master
# gc bugs => git checkout bugs
function gc {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}


#########
# OTHER #
#########
alias sync='/Applications/synergy/synergyc -f curry-macdaddy.local'
alias syns='/Applications/synergy/synergys -c ~/synergy.conf -f'
alias r='iterm.sh $1'

