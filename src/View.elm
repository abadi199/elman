module View exposing (view)

import Time exposing (Time)
import Model exposing (Model)
import Msg exposing (Msg)
import Html as H exposing (Html)
import Html.Attributes as H
import Svg as S
import Svg.Attributes as S exposing (style)
import View.Pacman as View
import View.Dot as View
import Matrix
import Array


view : ( Time, Model ) -> Html Msg
view ( time, model ) =
    let
        container =
            H.div [ H.style [ ( "width", "100vw" ), ( "height", "100vh" ), ( "background-color", "#fff" ), ( "overflow", "hidden" ) ] ]

        viewPort =
            S.svg
                [ S.width "100%"
                , S.height "100%"
                , S.viewBox <| "0 0 " ++ (toString <| Model.width model.world) ++ " " ++ (toString <| Model.height model.world)
                ]

        background =
            S.rect [ S.x "0", S.y "0", S.width "100%", S.height "100%", S.fill "#000" ] []
    in
        container
            [ viewPort
                [ background
                , level model.world
                , View.pacman time model.world model.hero
                ]
            ]


level : Model.World -> Html Msg
level world =
    let
        tileSize =
            Model.tileSize world

        toCoordinate ( ( col, row ), a ) =
            ( ( col * tileSize, row * tileSize ), a )

        tiles =
            world.level
                |> Matrix.toIndexedArray
                |> Array.map toCoordinate
                |> Array.map (View.dot world)
                |> Array.toList
    in
        S.g [] tiles
