#!/bin/sh
#
# Requires https://www.gnu.org/software/time/
#
# Outputs the measurements and writes them to `data.csv`. Use `plot.gpi` to plot
# `data.csv`.
#

if [ ! -e /usr/bin/time ]; then
    echo "/usr/bin/time not found" >&2
    exit 1
fi

cargo clean

cd 00_struct
echo "prebuilding dependencies.."
cargo build --release || exit 1

cd -

echo "number_of_fields  time"

for i in `find -maxdepth 1 -name "*_struct" -type d | sort -n`; do
    fields0=${i##./}
    fields1=${fields0%_struct}
    fields=${fields1##0}
    echo -n "$fields "
    (
	cd $i
	/usr/bin/time -f "%e" cargo build --release -q
    ) 2>&1
done | tee data.csv
