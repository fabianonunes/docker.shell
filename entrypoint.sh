#!/bin/bash

cmd="$1"

if [[ "$cmd" == "wait" ]]; then
  exec pid1 -- tail -f /dev/null
fi

exec /bin/bash
