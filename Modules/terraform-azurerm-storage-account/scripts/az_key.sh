#!/bin/bash
set -x
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


if [[ -z "$AZURE_CLIENT_ID" ]]; then
	type="TFE"
fi


if  [[ $type == "TFE" ]]; then
	sleep 25
	counter=1
	while [[ $counter -le 5 ]] ; do
 	# shellcheck disable=SC2154
		az keyvault storage add --vault-name "${vault_name}" -n "${storage_name}" --active-key-name key1 --auto-regenerate-key --regeneration-period P60D --resource-id  "${storage_id}" && break
    	((counter++))
		sleep 25
	done

else
	az login --service-principal -u "${AZURE_CLIENT_ID}" -p "${AZURE_CLIENT_SECRET}" --tenant "${AZURE_TENANT_ID}"
	sleep 25
	counter=1
	while [[ $counter -le 5 ]] ; do
 	# shellcheck disable=SC2154
		az keyvault storage add --vault-name "${vault_name}" -n "${storage_name}" --active-key-name key1 --auto-regenerate-key --regeneration-period P60D --resource-id  "${storage_id}" && break
    	((counter++))
		sleep 25
	done
fi
