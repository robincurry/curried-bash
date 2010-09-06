#
# Multiplatform bashrc for use on OS X and Linux (Debian or RedHat families)
#

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. (from Debian)
shopt -s checkwinsize


#
# Aliases
#

. ~/.bash_aliases


#
# Tab completion
#

# Homebrew
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
# MacPorts (only test if not homebrew)
elif [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Debian
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Shell prompt
#

. ~/.bash_prompt


#
# System-specific stuff
#

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

