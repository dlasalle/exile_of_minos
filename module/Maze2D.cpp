/**
* @file Maze2D.cpp
* @brief Implementation of the Maze2D class.
* @author Dominique LaSalle <dominique@solidlake.com>
* Copyright 2018
* @version 1
* @date 2018-10-02
*/


#include "Maze2D.hpp"

#include "Graph.hpp"
#include "DepthFirstMazeGenerator.hpp"


/******************************************************************************
* ALIASES *********************************************************************
******************************************************************************/

using Graph = procedured::Graph;
using DepthFirstMazeGenerator = procedured::DepthFirstMazeGenerator;


/******************************************************************************
* HELPER FUNCTIONS ************************************************************
******************************************************************************/

namespace
{

void fill(
    GridMap * const map,
    int const startX,
    int const startY,
    int const startZ,
    int const sizeX,
    int const sizeY,
    int const sizeZ,
    int const id)
{
  for (int z = startZ; z < startZ+sizeZ; ++z) {
    for (int y = startY; y < startY+sizeY; ++y) {
      for (int x = startX; x < startX+sizeX; ++x) {
        // godot treats y as up, not z.
        map->set_cell_item(x,z,y,id);
      }
    }
  }
}

}


/******************************************************************************
* CONSTRUCTORS / DESTRUCTOR ***************************************************
******************************************************************************/

Maze2D::Maze2D() :
  m_seed(0),
  m_x_offset(0),
  m_y_offset(0),
  m_z_offset(0),
  m_floor_height(1),
  m_wall_height(2),
  m_border_height(2),
  m_floor_id(0),
  m_wall_id(1),
  m_border_id(2),
  m_ceiling_id(3),
  m_wall_width(1),
  m_floor_width(1),
  m_has_ceiling(false)
{
  // do nothing
}

/******************************************************************************
* PUBLIC METHODS **************************************************************
******************************************************************************/

void Maze2D::set_seed(
    const int seed)
{
  m_seed = seed;
}

void Maze2D::set_offset(
    const int x,
    const int y,
    const int z)
{
  m_x_offset = x;
  m_y_offset = y;
  m_z_offset = z;
}


void Maze2D::set_floor_height(
    int const height)
{
  m_floor_height = height;
}

void Maze2D::set_wall_height(
    int const height)
{
  m_wall_height = height;
}

void Maze2D::set_border_height(
    int const height)
{
  m_border_height = height;
}

void Maze2D::set_floor_id(
    int const id)
{
  m_floor_id = id;
}

void Maze2D::set_wall_id(
    int const id)
{
  m_wall_id = id;
}

void Maze2D::set_border_id(
    int const id)
{
  m_border_id = id;
}

void Maze2D::set_ceiling_id(
    int const id)
{
  m_ceiling_id = id;
}

void Maze2D::set_floor_width(
    int const width)
{
  m_floor_width = width;
}

void Maze2D::set_wall_width(
    int const width)
{
  m_wall_width = width;
}


void Maze2D::set_has_ceiling(
    bool p_has_ceiling)
{
  m_has_ceiling = p_has_ceiling;
}

void Maze2D::build(
    Object * const objMap,
    int const width,
    int const length)
{
  GridMap * const map = Object::cast_to<GridMap>(objMap);
  // build a graph
  Graph graph(width*length);

  // add edges
  for (int y = 0; y < length; ++y) {
    for (int x = 0; x < width; ++x) {
      if (x + 1 < width) {
        graph.add_edge((y*width) + x, (y*width) + x + 1);
      }
      if (y + 1 < length) {
        graph.add_edge((y*width) + x, ((y+1)*width) + x);
      }
    }
  }

  // generate maze
  DepthFirstMazeGenerator mzg(static_cast<unsigned int>(m_seed));
  Graph maze = mzg.generate(&graph);
  
  // fill maze floor base points
  for (int i = 0; i < length; ++i) {
    for (int j = 0; j < width; ++j) {
      // set floor
      int const offsetX = j*(m_floor_width+m_wall_width)+m_x_offset;
      int const offsetY = i*(m_floor_width+m_wall_width)+m_y_offset;
      fill(map, offsetX, offsetY, m_z_offset, m_floor_width, \
          m_floor_width, m_floor_height, m_floor_id);
    }
  }

  // fill maze floor pillars 
  for (int i = 0; i < length-1; ++i) {
    for (int j = 0; j < width-1; ++j) {
      // set floor
      int const offsetX = (j+1)*m_floor_width+(j*m_wall_width)+m_x_offset;
      int const offsetY = (i+1)*m_floor_width+(i*m_wall_width)+m_y_offset;
      fill(map, offsetX, offsetY, m_z_offset, m_wall_width, \
          m_wall_width, m_wall_height, m_wall_id);
    }
  }

  // fill in hallways and floors
  for (int i = 0; i < length; ++i) {
    for (int j = 0; j < width; ++j) {
      // check hallway down
      if (i + 1 < length) {
        int const source = i * width + j;
        int const dest = (i+1) * width + j;

        int const offsetX = j*(m_floor_width+m_wall_width)+m_x_offset;
        int const offsetY = (i+1)*m_floor_width+(i*m_wall_width)+m_y_offset;

        int fill_id;
        int height;
        if (maze.is_connected(source, dest)) {
          fill_id = m_floor_id;
          height = m_floor_height;
        } else {
          fill_id = m_wall_id;
          height = m_wall_height;
        }
        
        fill(map, offsetX, offsetY, m_z_offset, m_floor_width, \
            m_wall_width, height, fill_id);
      } 
      // check hallway right
      if (j + 1 < width) {
        int const source = i * width + j;
        int const dest = i * width + j+1;

        int const offsetX = (j+1)*m_floor_width+(j*m_wall_width)+m_x_offset;
        int const offsetY = i*(m_floor_width+m_wall_width)+m_y_offset;

        int fill_id;
        int height;
        if (maze.is_connected(source, dest)) {
          fill_id = m_floor_id;
          height = m_floor_height;
        } else {
          fill_id = m_wall_id;
          height = m_wall_height;
        }
        
        fill(map, offsetX, offsetY, m_z_offset, m_wall_width, \
            m_floor_width, height, fill_id);
      }
    }
  }

  // fill ceiling 
  if (m_has_ceiling) {
    fill(map, m_x_offset-1, m_y_offset-1, m_border_height+m_z_offset, \
        width*m_floor_width+(width-1)*m_wall_width+2, \
        length*m_floor_width+(length-1)*m_wall_width+2, \
        1, m_ceiling_id);
  }

  // fill border 
  int const total_length = (length*m_floor_width)+((length-1)*m_wall_width);
  int const total_width = (width*m_floor_width)+((width-1)*m_wall_width);
  fill(map, m_x_offset-1, m_y_offset-1, m_z_offset, total_width+2, \
      1, m_border_height, m_border_id);
  fill(map, m_x_offset-1, m_y_offset+total_length, m_z_offset, \
      total_width+2, 1, m_border_height, m_border_id);

  fill(map, m_x_offset-1, m_y_offset, m_z_offset, 1, \
      total_length, m_border_height, m_border_id);
  fill(map, m_x_offset+total_width, m_y_offset, m_z_offset, 1, \
      total_length, m_border_height, m_border_id);
}

/******************************************************************************
* STATIC PROTECTED METHODS ****************************************************
******************************************************************************/

void Maze2D::_bind_methods()
{
  ClassDB::bind_method(D_METHOD("set_seed", "seed"), &Maze2D::set_seed);

  ClassDB::bind_method(D_METHOD("set_offset", "x", "y", "z"), \
      &Maze2D::set_offset);

  ClassDB::bind_method(D_METHOD("set_floor_height", "floor_height"), \
      &Maze2D::set_floor_height);
  ClassDB::bind_method(D_METHOD("set_wall_height", "wall_height"), \
      &Maze2D::set_wall_height);
  ClassDB::bind_method(D_METHOD("set_border_height", "border_height"), \
      &Maze2D::set_border_height);

  ClassDB::bind_method(D_METHOD("set_floor_id", "floor_id"), \
      &Maze2D::set_floor_id);
  ClassDB::bind_method(D_METHOD("set_wall_id", "wall_id"), \
      &Maze2D::set_wall_id);
  ClassDB::bind_method(D_METHOD("set_border_id", "border_id"), \
      &Maze2D::set_border_id);
  ClassDB::bind_method(D_METHOD("set_ceiling_id", "ceiling_id"), \
      &Maze2D::set_ceiling_id);

  ClassDB::bind_method(D_METHOD("set_wall_width", "wall_width"), \
      &Maze2D::set_wall_width);
  ClassDB::bind_method(D_METHOD("set_floor_width", "floor_width"), \
      &Maze2D::set_floor_width);

  ClassDB::bind_method(D_METHOD("set_has_ceiling", "has_ceiling"), \
      &Maze2D::set_has_ceiling);

  ClassDB::bind_method(D_METHOD("build", "map", "width", "length"), \
      &Maze2D::build);
}

