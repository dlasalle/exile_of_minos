/**
* @file Maze2D.hpp
* @brief The Maze2D class.
* @author Dominique LaSalle <dominique@solidlake.com>
* Copyright 2018
* @version 1
* @date 2018-10-01
*/


#ifndef LABYRINTH_MAZE2D_HPP
#define LABYRINTH_MAZE2D_HPP

#include "core/reference.h"
#include "modules/gridmap/grid_map.h"

class Maze2D : public Reference 
{
  GDCLASS(Maze2D, Reference);

  public:
    Maze2D();

    void set_seed(
        int seed);

    void set_offset(
        int x,
        int y,
        int z);

    void build(
        Object * map,
        int width,
        int length,
        int wall_id);

  protected:
    static void _bind_methods();

  private:
    int m_seed;
    int m_x_offset;
    int m_y_offset;
    int m_z_offset;
};

#endif
