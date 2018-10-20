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

    void set_floor_height(
        int height);

    void set_wall_height(
        int height);

    void set_border_height(
        int height);

    void set_floor_id(
        int id);

    void set_wall_id(
        int id);

    void set_border_id(
        int id);

    void set_ceiling_id(
        int id);

    void set_floor_width(
        int width);

    void set_wall_width(
        int width);

    void set_has_ceiling(
        bool has_ceiling);

    void build(
        Object * map,
        int width,
        int length);

  protected:
    static void _bind_methods();

  private:
    int m_seed;
    int m_x_offset;
    int m_y_offset;
    int m_z_offset;
    int m_floor_height;
    int m_wall_height;
    int m_border_height;
    int m_floor_id;
    int m_wall_id;
    int m_border_id;
    int m_ceiling_id;
    int m_wall_width;
    int m_floor_width;
    bool m_has_ceiling;
};

#endif
