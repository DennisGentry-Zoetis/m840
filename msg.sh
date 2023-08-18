# "source" this from an executable shell script to get a "msg"
# function that is better than plain "echo."
#
# msg attributes the messages to the "calling" script, plus the
# messages are colorized on color terminals.
#
# It provides log level names in colored/emphasized text.  For example:
# msg "${info}Some useful info"

myname=$(basename "$0")

# Variables for colors/contrast
if [[ $TERM == *"color"* ]]; then
    txtund=$(tput sgr 0 1)    # Underline
    txtbld=$(tput bold)       # Bold
    red=$(tput setaf 1)
    yel=$(tput setaf 3)
    blu=$(tput setaf 4)
    wht=$(tput setaf 7)
    rst=$(tput sgr0)       # Reset
else
    txtund="_"
    txtbld="*"
    red=""
    yel=""
    blu=""
    wht=""
    rst=""
fi
bldred=${txtbld}${red}
bldyel=${txtbld}${yel}
bldblu=${txtbld}${blu}
bldwht=${txtbld}${wht}

info="${bldwht}info: ${rst}"
warn="${bldyel}warning: ${rst}"
err="${bldred}error: ${rst}"

# Save message color, if any, for use by callers
msgc=$rst
msg() {
    if [[ " "$SUPER_QUIET != True ]]; then
        printf "$bldblu${myname}: ${rst}$*${rst}\n"
    fi
}

# No newline after
msgn() {
    if [[ " "$SUPER_QUIET != True ]]; then
        printf "$bldblu${myname}: ${rst}$*${rst}"
    fi
}

# Get shellcheck to shut up about these being unused
echo "$txtund $info $pass $warn $ques" >/dev/null
