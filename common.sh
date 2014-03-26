#!/usr/bin/env bash

export IS_UBUNTU=
export IS_OSX=

if [[ "$OSTYPE" =~ ^linux ]]; then
    export IS_UBUNTU=1
fi

if [[ "$OSTYPE" =~ ^darwin ]]; then
    export IS_OSX=1
fi

# Text color variables
txtund=$(tput sgr 0 1)
txtbld=$(tput bold)
txtred=$(tput setaf 1)
txtgrn=$(tput setaf 2)
txtblu=$(tput setaf 4)
txtwht=$(tput setaf 7)
txtrst=$(tput sgr0)

e_header() {
    echo "\n"$txtund$@$txtrst
}
e_info() {
    echo $txtwht$@$txtrst
}
e_success() {
    echo $txtgrn$@$txtrst
}
e_pass() {
    echo $txtblu$@$txtrst
}
e_warn() {
    echo $txtred$@$txtrst
}
