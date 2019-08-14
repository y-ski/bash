#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# grep
if [ -x /usr/bin/dircolors ]; then
    alias grep='grep --color=always'              # show differences in colour
    alias egrep='egrep --color=always'            # show differences in colour
    alias fgrep='fgrep --color=always'            # show differences in colour
fi
#
# Some shortcuts for different directory listings
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls -hF --color=always --group-directories-first'       # classify files in colour
fi
alias dir='ls --format=vertical'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias lla='ls -Al'                            # all but . and ..
alias l='ls -CF'                              #
#
# change directory
alias ..='cd ..'
#
# editor
if [ -f /usr/bin/nvim ]; then
    alias vi='nvim'
fi
#
# Misc :)
alias less='less -riMRX'                      # raw control characters
alias whence='type -a'                        # where, of a sort
alias his='history'
alias diff='diff -u --strip-trailing-cr --ignore-all-space --ignore-blank-lines'

