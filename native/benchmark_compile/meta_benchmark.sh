#!/bin/bash
#
# Run benchmark.sh on different branches
#

branches=(master 299-speed-up-decoder-compilation)
declare -A commits
commits[NifStruct]=f00d79b
commits[NifMap]=0b6efcc
commits[NifTuple]=0fba4f9
commits[NifRecord]=456d6f0

original_pwd=$(pwd)

finish() {
    cd $original_pwd
    git checkout .
    git checkout master
    exit
}

trap finish INT TERM EXIT

abort() {
    echo >&2 $0
    exit 1
}

for desc in "${!commits[@]}"; do
    commit=${commits[$desc]}
    echo Benchmarking $desc with $commit

    for branch in "${branches[@]}"; do
	git checkout $commit &> /dev/null || abort "git checkout $commit failed"

	sed -i "s/master/$branch/g" */Cargo.toml

	RUSTFLAGS=-Awarnings ./benchmark.sh || abort "benchmark failed"
	git checkout . &> /dev/null || abort "git checkout . failed"

	./plot.gpi
	mv plot.pdf "${desc}_${branch}.pdf"
	mv plot.png "${desc}_${branch}.png"
    done
done
