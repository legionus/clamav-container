#!/bin/sh -efu

sock="${CLAMAV_VOLUME-}"/clamd.sock

[ -S "$sock" ] ||
	exit 1

echo PING |
	socat STDIO UNIX-CLIENT:"$sock" 2>&1 |
	grep -qs PONG
