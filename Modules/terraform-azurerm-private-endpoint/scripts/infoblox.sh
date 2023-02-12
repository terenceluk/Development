#!/bin/bash
# Short form: set -e
set -o errexit

# Print a helpful message if a pipeline with non-zero exit code causes the
# script to exit as described above.
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR

# Allow the above trap be inherited by all functions in the script.
#
# Short form: set -E
set -o errtrace

# Return value of a pipeline is the value of the last (rightmost) command to
# exit with a non-zero status, or zero if all commands in the pipeline exit
# successfully.
set -o pipefail

# Set $IFS to only newline and tab.
#
# http://www.dwheeler.com/essays/filenames-in-shell.html
IFS=$'\n\t'

SERVER="ddi.ctc"

##### Begin Script #####

function DELETE () {
### DELETE HOST ###
echo -e "Delete DNS: ${HOST} "
GET_A=$(/usr/bin/curl -k -u "${login}" -X GET https://${SERVER}/wapi/v2.7.3/record:a?name="${HOST}"."${DOMAIN}" 2> /dev/null | grep "_ref" | head -n1 | awk -F\" '{print $4}')
GET_PTR=$(/usr/bin/curl -k -u "${login}" -X GET https://${SERVER}/wapi/v2.7.3/record:ptr?ptrdname="${HOST}"."${DOMAIN}" 2> /dev/null | grep "_ref" | head -n1 | awk -F\" '{print $4}')

if [ -z "$GET_A" ]; then
  echo "Error: Could not find reference to ${HOST}.${DOMAIN}"
  exit 3
else
  echo -e "...removing A-Record"
  if ! /usr/bin/curl -k -u "${login}" -X DELETE https://${SERVER}/wapi/v2.7.3/"${GET_A}" 2> /dev/null
  then
    echo "Error, Could not complete A record removal"
    exit 3
  fi
fi

if [ -z "$GET_PTR" ]; then
  echo "Error: Could not find reference to ${HOST}.${DOMAIN}"
  exit 3
else
  echo -e "...removing PTR-Record"
  if ! /usr/bin/curl -k -u "${login}" -X DELETE https://${SERVER}/wapi/v2.7.3/"${GET_PTR}" 2> /dev/null
  then
    echo "Error, Could not complete PTR record removal"
    exit 3
  fi
fi

}

function ADD () {
### Update DNS record for HOST ###
echo -e "Adding A-Record"
if ! /usr/bin/curl -k -u "${login}" -H "Content-Type:application/json" -X POST https://${SERVER}/wapi/v2.7.3/record:a -d \
  "{\"name\":\"${HOST}.${DOMAIN}\",\"ipv4addr\":\"${IPv4}\",\"ttl\":300}" 2> /dev/null
then
  echo "Error, Could not complete A record Creation"
  exit 3
fi

echo -e "Adding PTR-Record"
if ! /usr/bin/curl -k -u "${login}" -H "Content-Type:application/json" -X POST https://${SERVER}/wapi/v2.7.3/record:ptr -d \
  "{\"ptrdname\":\"${HOST}.${DOMAIN}\",\"ipv4addr\":\"${IPv4}\",\"ttl\":300}" 2> /dev/null
then
  echo "Error, Could not complete PTR record creation"
  exit 3
fi
}

function usage () {
  ### Display the script arguments.
  printf "Usage: %s [-du] -h  -i \\n\\n" "$0"
  printf "Requires one option!\\n"
  printf "\\t-d: Delete a s% HOST record\\n" "${DOMAIN}"
  printf "\\t-u: Update/Add a %s HOST record\\n\\n" "${DOMAIN}"
}

while getopts "duh:D:l:i:" ARG; do
  # shellcheck disable=SC2020
  # shellcheck disable=SC2060
  case "${ARG}" in
    d) [ -z "$ACTION" ] && ACTION="D";;
    u) [ -z "$ACTION" ] && ACTION="U";;
    h) HOST="$(echo "$OPTARG" | tr [:upper:] [:lower:])";;
    D) DOMAIN="$(echo "$OPTARG" | tr [:upper:] [:lower:])";;
    l) login="$OPTARG";;
    i) IPv4="$OPTARG";;
    ?) echo "Invalid option -$OPTARG"; exit 1;;
  esac
done
shift $((OPTIND -1))

if [ "$ACTION" == "U" ]; then
  [ -z "$IPv4" ] && { echo "Error: Missing IP" && exit 1; }
  [ -z "$HOST" ] && { echo "Error: Missing hostname" && exit 1; }
  [ -z "$DOMAIN" ] && { echo "Error: Missing hostname" && exit 1; }
  ADD
  exit 0
elif [ "$ACTION" == "D" ]; then
  [ -z "$HOST" ] && { echo "Error: Missing HOST" && exit 1; }
  [ "$(host "${HOST}"."${DOMAIN}" | awk '{print $NF}')" = "3(NXDOMAIN)" ] && { echo "Error: No existing record found" && exit 1; }
	[ -z "$IPv4" ] && IPv4=$(host "${HOST}"."${DOMAIN}" | awk '{print $NF}')
  [ -z "$IPv4" ] && { echo "Error: Missing IP" && exit 1; }
   DELETE
   exit 0
else
  usage && exit 1;
fi