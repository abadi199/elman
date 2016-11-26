module Levels.Level1 exposing (level1)

import Matrix exposing (Matrix)
import Model


level1 : Matrix Model.Tile
level1 =
    Matrix.repeat 128 72 (Model.Path Model.Dot)
