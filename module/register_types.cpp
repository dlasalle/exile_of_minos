/**
 * @file register_types.cpp
 * @brief Implementation of register types functions.
 * @author Dominique LaSalle <dominique@solidlake.com>
 * Copyright 2018
 * @version 1
 * @date 2018-02-23
 */


#include "register_types.h"
#include "Maze2D.hpp"

#include "core/class_db.h"


void register_labyrinth_types()
{
  ClassDB::register_class<Maze2D>(); 
}

void unregister_labyrinth_types()
{
  // nothing to do
}
