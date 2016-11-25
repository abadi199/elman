module Main exposing (main)

import Html as H exposing (Html)
import Html.Attributes as H
import AnimationFrame
import Time exposing (Time)
import Svg as S
import Svg.Attributes as S exposing (style)
import Assets.Pacman as Assets


main : Program Never ( Time, Model ) Msg
main =
    H.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { move : Bool }


type Direction
    = Up
    | Down
    | Left
    | Right


type Msg
    = TimeUpdated Time


init : ( ( Time, Model ), Cmd Msg )
init =
    ( ( 0, Model False ), Cmd.none )


subscriptions : ( Time, Model ) -> Sub Msg
subscriptions ( _, model ) =
    Sub.batch [ AnimationFrame.times TimeUpdated ]


update : Msg -> ( Time, Model ) -> ( ( Time, Model ), Cmd Msg )
update msg ( time, model ) =
    case msg of
        TimeUpdated updatedTime ->
            ( ( updatedTime, model ), Cmd.none )


view : ( Time, Model ) -> Html Msg
view ( time, model ) =
    H.div [ H.style [ ( "width", "100%" ), ( "height", "100%" ), ( "background-color", "#fff" ) ] ]
        [ S.svg
            [ S.width "100%", S.height "100%", S.viewBox "0 0 1280 720" ]
            [ S.rect [ S.x "0", S.y "0", S.width "100%", S.height "100%", S.fill "#000" ] []
            , Assets.pacman time model.move
            ]
        ]
