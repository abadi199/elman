module Levels.Level1 exposing (level1)

import Matrix exposing (Matrix)
import Model.Tile as Tile


level1 : Matrix Tile.Tile
level1 =
    Matrix.repeat 32 18 (Tile.Path Tile.LRC Tile.Dot)
