#!/bin/sh
set -eu

cd "`dirname "$0"`"

run() {
	echo ">" "$@"
	"$@"
}

run cp acpi-data-gather /usr/local/bin
run cp acpi-data-gather.service /etc/systemd/system
