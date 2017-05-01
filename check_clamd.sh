#!/bin/sh -efu

sock="${CLAMAV_VOLUME-}"/clamd.sock

[ -S "$sock" ] && [ "$(echo PING | socat -t 15 STDIO UNIX-CLIENT:"$sock")" = "PONG" ] ||
	exit 1
