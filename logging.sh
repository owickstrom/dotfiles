#!/usr/bin/env bash

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
