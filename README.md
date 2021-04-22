# acpi-data-gather: Gather ACPI information, at boot and after hibernation

This script (triggered by a systemd service) collects ACPI information
during boot and after waking up from hibernation.

## Motivation

Sometimes after waking up from hibernations I had some problems with the ACPI tables
on my installation. To collect data hopefully useful in debugging this, this
script was created.

## Usage

### Installation

There is a `install.sh` that copies `acpi-data-collect` to `/usr/local/bin` and
installs a `acpi-data-collect.service` file. To actually enable that service you have
to run:

   systemctl enable acpi-data-collect.service

### Dependencies

(optional): [bootcounter][bootcounter], for better naming of collected data sets

### Collected data

The script collects this data:

- contents of `/sys/firmware/acpi/tables` (for this to succeed the script needs to be run as `root`)
- output of `dmesg` and `dmidecode`
- `kern.log` and `syslog` (compressed if they are >=1MB)

The script expects an output directory as first (and only) parameter and
creates a new subdirectory for each run. If [`bootcounter`][bootcouter] is installed,
the subdirectory will be called `$BOOTNUMBER-$RUNNINGNUMBER`. Without `bootcounter`,
`$BOOTNUMBER` will always be `0`.

For example:

    $ acpi-data-collect datadir
    $ ls -l datadir/0-1
    total 24032
    -rw-r--r-- 1 root staff    87171 Apr 19 13:56 dmesg
    -rw-r--r-- 1 root staff    22702 Apr 19 13:56 dmidecode
    -rw-r----- 1 root staff 24395994 Apr 19 13:56 kern.log.gz
    -rw-r----- 1 root staff    88437 Apr 19 13:56 syslog
    drwxr-sr-x 4 root staff     4096 Apr 19 13:56 tables

If the systemd service is enabled, the script runs automatically at boot and
after hibernation. The collected data is stored in subdirectories of
`/var/local/acpi-gather-data/`.


 [bootcounter]: https://github.com/sth/bootcounter
