# Exile of Minos

A simple 3D maze game.

## Building

Because this game makes use of C++ modules, you will need to build the Godot
game engine from source.

First, you will need to pull in the submodules after cloning:
```
git submodule update --init --recursive
```

Then, to configure Godot to build the modules, run the `setup_modules.sh`
script:
```
./setup_modules.sh
```

This creates links in the `/godot/thirdparty` and `/godot/modules` directories.

Once you have done that, enter the Godot directory and run `scons` for your
target platform. For Linux, do:

```
cd godot/
scons platform=x11
```

## Running the game

After you have build Godot, you can play the game by entering the project
directory, and running godot:
```
cd project/
../godot/bin/godot.x11.tools.64
```

## Editing the game

After you have built Godot, can launch the editor with the `-e` command: 
```
cd project/
../godot/bin/godot.x11.tools.64 -e
```

## Screenshots

![01](/images/exile_of_minos_01.png)

![02](/images/exile_of_minos_02.png)

![03](/images/exile_of_minos_03.png)

![04](/images/exile_of_minos_04.png)

