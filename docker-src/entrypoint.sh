#!/bin/sh

PASSHASH=$(python3 -c "from notebook.auth import passwd; print(passwd('$PASS', 'sha1'))")

echo "Notebook Password: '$PASS'"

# Disables tensorflow whining about numa nodes
for a in /sys/bus/pci/devices/*; do
    echo 0 | tee -a $a/numa_node > /dev/null
done

# Continue execution
PASSHASH=$PASSHASH exec "$@"
