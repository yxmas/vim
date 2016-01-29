# yxmas's settings on bashrc
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

PS1="\e[4;32m\t ${debian_chroot:+($debian_chroot)}\u@\h:\w \e[0m\n\$"

export PS1 

