#/bin/bash
#
# Created by: Brian Dones
# Revision History
# - Nov 07, 2016 - Brian Dones <Brian.Dones@gmail.com
# File Name - 
# Description: message...

# Script/Configuration Variables

#DEBUG: control whether to output debug messages
# 1 - yes, 2 - no
DEBUG=1

# !!! END OF CONFIGURATION VARIABLES !!!
# !!! NO MORE EDITS BEYOND THIS LINE !!!

#
# Bring in libraries...
#
source functions.sh

#
# Custom/Program Functions...
#

usage() {
  echo
  echo "Usage: $0 [-tdh] -e email"
  echo " -h Print this usage message"
  echo " -t Generate a top report"
  echo " -d Generate a df report"
  echo " -e email Recipient for the generated reports"
  echo
}

topreport() {
  top -bn 1 | mailx -s "Top report" $email
}

dfreport() {
  df -h | mailx -s "df report" $email
}

#
# Program Variables (for definition and initialization )
#

#Email to send reports to
email=''

# Flag to track whether user is requesting a top report
topreport=0

# Flag to track whether user is requesting a df report
dfreport=0

#
# Main Code Block ...
#

while getopts ":thde:" opt; do
  case $opt in
    h)
      usage
      succeed
    ;;
    t)
      debug "Top report requested"
      topreport=1
    ;;
    d)
      debug "df report requested"
      dfreport=1
    ;;
    e)
      debug "Email is '$OPTARG'"
      email=$OPTARG
    ;;
    \?)
      usage
      fail 5 "Invalid option: -$OPTARG"
    ;;
    :)
      usage
      fail 5 "Option -$OPTARG requires an argument."
    ;;
  esac
done

#
#Playing with getopts..
#
debug "Argument processing by getopts is complete."
debug "OPTIND is set to '$OPTIND'"

#
# TODO:
# Syntax Checks:
# - Think about checking validity/presence of email address
# - Maybe also make sure at least one report was requested?
#

# Make sure user supplied an email address..
if [ -z "$email" ]
  then
    usage
    fail 5 "Email address required for reports"
fi

if [ "$topreport" -eq 1 ]
  then
    topreport
fi

if [ "$dfreport" -eq 1 ]
  then
    dfreport
fi

succeed
