module Model
    exposing
        ( Model
        , World
        , Direction(..)
        , Position
        , Hero
        , Dimension
        , TileSize
        , Level
        , frameConstant
        , world
        , width
        , height
        , tileSize
        )

import Matrix exposing (Matrix)
import Model.Tile as Tile


type alias Model =
    { world : World
    , hero : Hero
    }


type alias Level =
    Matrix Tile.Tile


type alias World =
    { tileSize : TileSize
    , level : Level
    }


world : Int -> Level -> World
world tileSize level =
    { tileSize = TileSize tileSize
    , level = level
    }


width : World -> Int
width world =
    Matrix.width world.level * tileSize world


height : World -> Int
height world =
    Matrix.height world.level * tileSize world


tileSize : World -> Int
tileSize world =
    case world.tileSize of
        TileSize tileSize ->
            tileSize


type Dimension
    = Dimension Int Int


type TileSize
    = TileSize Int


type alias Hero =
    { move : Bool
    , direction : Direction
    , position : Position
    , speed : Int
    }


type alias Position =
    { x : Int, y : Int }


type Direction
    = Up
    | Down
    | Left
    | Right


frameConstant : Int
frameConstant =
    6000
