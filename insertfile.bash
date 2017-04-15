#!/usr/bin/env bash
# pass insertfile - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2017 HacKan <hackan@gmail.com>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

cmd_insertfile_usage() {
	cat <<-_EOF
	Usage:
	    $PROGRAM insertfile [--help,-h] [--force,-f] pass-name file-path
	        Insert a file into the store. Prompt before
	        overwriting existing file unless forced (--force,-f).

	More information may be found in the pass-insertfile(1) man page.
	_EOF
}

cmd_insertfile() {
	local opts force=0
	opts="$($GETOPT -o f -l force -n "$PROGRAM $COMMAND" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-f|--force) force=1; shift ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || $# -ne 2 ]] && die "Usage: $PROGRAM $COMMAND [--help,-h] [--force,-f] pass-name file-path"

        local path="${1%/}"
	local passfile="$PREFIX/$path.gpg"
	check_sneaky_paths "$path"

	[[ $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

	mkdir -p -v "$PREFIX/$(dirname "$path")"
	set_gpg_recipients "$(dirname "$path")"

	local filepath="${2}"
	[[ -r "${filepath}" && -L "${filepath}" ]] && yesno "The file is a symlink and it's going to be resolved. Are you sure you want that?"

	if [[ -r "${filepath}" && -f "${filepath}" ]]; then
		check_sneaky_paths "${filepath}"
		$GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" "${filepath}" || die "File encryption aborted."
	else
		die "File ${filepath} is not valid."
	fi

	git_add_file "$passfile" "Add given file for $path to store."
}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_insertfile_usage && exit 0

cmd_insertfile "$@"
