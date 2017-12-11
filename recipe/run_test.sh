#!/bin/bash

command -v mpichversion
mpichversion

command -v mpicc
mpicc -show

command -v mpiexec

pushd $RECIPE_DIR/tests

function mpi_exec() {
  # use pipes to avoid O_NONBLOCK issues on stdin, stdout
  mpiexec -launcher fork $@ 2>&1 </dev/null | cat
}

mpicc helloworld.c -o helloworld_c
mpi_exec -n 4 ./helloworld_c

popd
