#!/bin/bash

pushd godot/thirdpart
ln -s ../../procedured ./
popd

pushd godot/modules
ln -s ../../thespian ./
ln -s ../../module ./labyrinth
popd
