module Model
    exposing
        ( Model
        , World
        , Direction(..)
        , Position
        , Hero
        , frameConstant
        )


type alias Model =
    { world : World
    , hero : Hero
    }


type alias World =
    { width : Int, height : Int }


type alias Hero =
    { move : Bool
    , direction : Direction
    , position : Position
    , speed : Int
    , radius : Int
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
