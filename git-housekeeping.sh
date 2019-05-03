#!/bin/bash

alias githousekeeping="f(){ \
echo => git housekeeping; \
if [[ \$# -eq 0 ]]; \
then \
echo what will you do; \
else \
echo found action \$1 ; \
    find . -name .git -type d -prune | while read d;
    do \
    cd \$d/..; \
    echo current directory \$PWD; \
    if [ \$1 == "check" ]; \
    then \
        echo action check; \
        git status --porcelain | awk '/^\\?\\?/ { print \$2; }'; \
        UPSTREAM=\${1:-@{u}}; \
        LOCAL=\$(git rev-parse @); \
        REMOTE=\$(git rev-parse \"$UPSTREAM\"); \
        BASE=\$(git merge-base @ \"$UPSTREAM\"); \
        if [ \$LOCAL = \$REMOTE ]; then \
            echo  \$PWD Up-to-date; \
        elif [ \$LOCAL = \$BASE ]; then \
            echo  \$PWD Need to pull; \
        elif [ \$REMOTE = \$BASE ]; then \
            echo  \$PWD Need to push; \
        else \
            echo  \$PWD Diverged; \
        fi; \
    elif [ \$1 == "push" ]; \
    then \
        echo action push; \
        git push; \
    elif [ \$1 == "pull" ]; \
    then \
        echo \$d action pull; \
        git pull origin master; \
    elif [ \$1 == "add" ]; \
    then \
        echo action add; \
        git add .;\
    elif [ \$1 == "commit" ]; \
    then \
        echo action commit; \
        git commit -am \"auto save\"
    else \
        echo action not found; \
    fi; \
    cd \$OLDPWD;
    done
fi; \
}; f"
