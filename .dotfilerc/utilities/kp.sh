### PROCESS
# mnemonic: [K]ill [P]rocess
# show output of "ps -ef", use [tab] to select one or multiple entries
# press [enter] to kill selected processes and go back to the process list.
# or press [escape] to go back to the process list. Press [escape] twice to exit completely.

## Reference - https://medium.com/@sidneyliebrand/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861

#1 /bin/bash

function kp {
  local pid=$(ps -ef | grep -Ev 'fzf|ps -ef|UID' | eval "fzf -m --header='[kill:process]'" | awk '{print $2}')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
