#! /bin/sh -e

# Exit on the first command that returns a nonzero code.
set -e

# Function that checks if a given executable is on the path. If it isn't, prints an install message and exits.
# Usage: check_binary EXECUTABLE_NAME INSTALL_MESSAGE
check_binary() {
  if ! which "$1" > /dev/null; then
    # Using a subshell to redirect output to stderr. It's cleaner this way and will play nice with other redirects.
    # https://stackoverflow.com/a/23550347/225905
    ( >&2 echo "$2" )
    # Exit with a nonzero code so that the caller knows the script failed.
    exit 1
  fi
}

check_binary "jq" "$(cat <<EOF
You will need jq to run this script.
Install it using your package manager. E.g. for homebrew:
brew install jq
EOF
)"

check_binary "shell2http" "$(cat <<EOF
You will need shell2http to run this script.
Install it using your package manager. E.g. for homebrew:
brew install msoap/tools/shell2http
EOF
)"

check_binary "upsc" "$(cat <<EOF
You will need nut to run this script.
EOF
)"

#websocketd --port=8080 bcmxcp_usb -a pw5115 -DDDDD 2>&1
#websocketd --port=8080 upsd -D

#shell2http -cgi /test 'echo "Content-Type: application/json\n"; echo "{\"error\": \"ok\"}"'

# http://server.lan:5256/upscmd/commands?ups=pw5115
# http://server.lan:5256/upscmd/exec?ups=pw5115&ups_user=admin&ups_password=admin&command=beeper.mute&value=false
shell2http -port 5256 -form -include-stderr -show-errors \
/upsc 'upsc $v_ups' \
/upsrw 'upsrw -s $v_var -u $v_ups_user -p $v_ups_password $v_ups' \
/upscmd/commands 'upscmd -l $v_ups' \
/upscmd/exec/ 'upscmd -u $v_ups_user -p $v_ups_password $v_ups $v_command $v_value'

docker-compose up -d --build
