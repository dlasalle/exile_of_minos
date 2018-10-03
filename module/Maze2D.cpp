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

using Graph = procedured::Graph;
using DepthFirstMazeGenerator = procedured::DepthFirstMazeGenerator;

/******************************************************************************
* CONSTRUCTORS / DESTRUCTOR ***************************************************
******************************************************************************/

Maze2D::Maze2D() :
  m_seed(0),
  m_x_offset(0),
  m_y_offset(0),
  m_z_offset(0)
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

void Maze2D::build(
    Object * const objMap,
    const int width,
    const int length,
    const int wall_id)
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
  
  // fill maze -- assume 2x scale
  for (int i = 0; i < 2*length - 1; ++i) {
    for (int j = 0; j < 2*width - 1; ++j) {
      if (i % 2 == 0 && j % 2 == 0) {
        // insert nothing
      } else if (i % 2 == 1 && j % 2 == 1) {
        // insert wall
        map->set_cell_item(j+m_x_offset, m_y_offset, i+m_z_offset, wall_id);
      } else {
        // check connectivity before inserting wall.
        const int source = std::ceil(i/2.0) * width + std::ceil(j/2.0);
        const int dest = std::floor(i/2.0) * width + std::floor(j/2.0);
        if (!maze.is_connected(source, dest)) {
          map->set_cell_item(j+m_x_offset, m_y_offset, i+m_z_offset, wall_id);
        }
      }
    }
  }
}

/******************************************************************************
* STATIC PROTECTED METHODS ****************************************************
******************************************************************************/

void Maze2D::_bind_methods()
{
  ClassDB::bind_method(D_METHOD("set_seed", "seed"), &Maze2D::set_seed);

  ClassDB::bind_method(D_METHOD("set_offset", "x", "y", "z"), \
      &Maze2D::set_offset);

  ClassDB::bind_method(D_METHOD("build", "map", "width", "length", "wall_id"), \
      &Maze2D::build);
}

