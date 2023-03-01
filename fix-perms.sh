#!/bin/bash
#credit to S.Simpson

function report_mkdir () {
    local tid="$1"
    local fmode="$2"
    local lfn="$3"

    local tail="${lfn#/*/*/*/}"
    local root="${lfn%/"$tail"}"

#    printf 'getfacl %q | setfacl --set-file=- %q\n' "$root" "$lfn" 
#    printf 'chmod 755 %q\n' "$lfn" 

    getfacl "$root" | setfacl --set-file=- "$lfn"
    chmod 755 "$lfn"
}

while read -r tid cmd arg1 arg2 ; do
    
    # args=()
    # while IFS= read -r -d '' arg ; do
    # 	args+=("$arg")
    # done < <(echo "$line" | xargs printf '%s\0')

    func="report_$cmd"
    args=("$tid" "$arg1" "$arg2")
    if [ "$(type -t "$func")" = "function" ] ; then
	"$func" "${args[@]}"
    else
	printf '\nSkipped %s; args:\n' "$func"
	printf '%q\n' "${args[@]}"
    fi
done
