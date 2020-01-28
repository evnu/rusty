# Rusty

Experimenting with [rustler](https://github.com/hansihe/rustler).

## Running the benchmark

```
$ mix deps.get
$ mix run -e Rusty.bench
```

## Run the PropCheck driven Echo Fuzzer

```
$ mix deps.get
$ mix test
```

This will most likely either run into a timeout, or into an error due to the atom table
exploding.

## Running a Compile Benchmark

`native/benchmark_compile/` contains a benchmark to evaluate how fast or slow `rustler_codegen` is. Run it with `benchmark.sh` in that directory.
