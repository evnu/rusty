#!/bin/sh

find -exec touch {} \;

cd 00_struct
echo "prebuilding dependencies.."
cargo build --release || exit 1

cd -

echo "number_of_fields,time"

for i in `find -maxdepth 1 -name "*_struct" -type d | sort -n`; do
    echo -n "$i "
    (
	cd $i
	(time (cargo build --release &> /dev/null)) 2>&1 | grep real | awk '{print $2;}'
    )
done
