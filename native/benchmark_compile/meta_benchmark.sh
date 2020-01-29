#!/bin/bash
#
# Run benchmark.sh on different branches
#

branches=(master 299-speed-up-decoder-compilation)
declare -A commits
commits[NifRecord]=456d6f0
commits[NifTuple]=0fba4f9
commits[NifMap]=0b6efcc
commits[NifStruct]=f00d79b

finish() {
    clean
    exit
}

clean() {
    (
	root_directory=$(git rev-parse --show-toplevel)
	cd $root_directory
	git checkout . &> /dev/null || abort "git checkout . failed"
	git checkout master &> /dev/null || abort "git checkout master failed"
    )
}

trap finish INT TERM EXIT

abort() {
    echo >&2 $1
    exit 1
}

for desc in "${!commits[@]}"; do
    commit=${commits[$desc]}
    echo Benchmarking $desc with $commit

    for branch in "${branches[@]}"; do
	clean

	git checkout $commit &> /dev/null || abort "git checkout $commit failed"

	sed -i "s/master/$branch/g" */Cargo.toml

	echo "  branch $branch of rustler_codegen"
	RUSTFLAGS=-Awarnings ./benchmark.sh &>/dev/null || abort "benchmark failed"

	./plot.gpi
	mv plot.pdf "${desc}_${branch}.pdf"
	mv plot.png "${desc}_${branch}.png"
    done
done
