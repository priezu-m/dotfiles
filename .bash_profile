export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
PS1='\e[1;35m\u@\h \e[0;32m$(pwd)\e[1;33m~\e[0;31m$\e[0m '

function vim
{
   /usr/bin/env vim "$@" && clear
}
shopt -s extglob
shopt -s expand_aliases
alias normich='norminette -R CheckForbiddenSourceHeader'
alias normicm='gcc -Wall -Wextra -glldb'
alias cclean='bash /Volumes/BREW/Cleaner_42.sh'

hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000029,"HIDKeyboardModifierMappingDst":0x700000039}, {"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' > /dev/null


export PATH="/usr/local/in:$PATH"
export PATH="/Volumes/brew/.brew/bin:$PATH"

loremipsum () {
if [ "${1}" = "" ] || [ "${2}" = "" ]; then
echo "Usage: loremipsum [paragraphs, sentences] [integer]"
else
curl -s http://metaphorpsum.com/"${1}"/"${2}" && printf "\n"
fi
}
