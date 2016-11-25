module Model exposing (Model, Direction(..))


type alias Model =
    { move : Bool
    , direction : Direction
    }


type Direction
    = Up
    | Down
    | Left
    | Right
