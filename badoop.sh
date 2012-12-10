#! /usr/bin/env bash

# vim:filetype=sh
if [[ "x$TODO" = x ]]; then
  TODO=~/.todo.txt
else
  TODO="$TODO"
fi

function todo_usage() {
  echo "todo:"
  echo "  -h: Print this help"
  echo "  -d: delete any todo items matching remaining arguments"
  echo "  with no flags: add the string passed in to the todo list"
  echo "  with no arguments: print out todo list"
}

# Badoop-done. Delete from todo list
function bedone() {
  # $@ is all the arguments passed in.
  # not sure what d is. Flag to delete anything that matches?
  if [[ -f "$TODO" ]]; then
    sed -i -e "/$@/d" "$TODO";
  fi
}

function todo() {
  # $# is the number of parameters passed in
  # command with no args just shows all todos

  if [[ $# == "0" ]]; then
    if [[ -f "$TODO" ]]; then
      cat "$TODO";
    fi
  elif [[ $1 == "-h" ]]; then
    todo_usage
  elif [[ $1 == "-d" ]]; then
    shift
    bedone $@
  else
    # adding a new todo
    # $@ is a string containing all parameters
    echo "  • $@" >> "$TODO"
  fi
}

todo $@
