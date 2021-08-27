#!/bin/bash -x
set -eE

# Script to test is it all dependencies installed through `type` command
# The dependency list is passed as a single positional parameter

# array to test for dependencies
test_third_party_dependencies(){
    while read line; do
        if ! type $line; then
            exit 1
        fi
    done < "$1"
}

notification(){
    echo
    echo "Dependencies successfully tested"
}

main(){
    # Entry point
    test_third_party_dependencies $1
    notification
}

main $1
exit 0
