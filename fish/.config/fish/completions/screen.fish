complete -c screen -e

complete -c screen -n "not __fish_seen_subcommand_from kill" -a "kill" -d "Kill a screen session"

complete -c screen -n "__fish_seen_subcommand_from kill" -f -a "(screen -ls | awk '/[0-9]+\./ {print \$1}')" -d "Screen Session PID"

complete -c screen -n "__fish_seen_subcommand_from -r -x" -f -a "(screen -ls | awk '/[0-9]+\./ {print \$1}')" -d "Screen Session PID"
