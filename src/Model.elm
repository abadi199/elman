module Model exposing (Model, Direction(..), Position, Hero, frameConstant)


type alias Model =
    { hero : Hero }


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


frameConstant =
    6000
