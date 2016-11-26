module View exposing (view)

import Time exposing (Time)
import Model exposing (Model)
import Msg exposing (Msg)
import Html as H exposing (Html)
import Html.Attributes as H
import Svg as S
import Svg.Attributes as S exposing (style)
import Assets.Pacman as Assets


view : ( Time, Model ) -> Html Msg
view ( time, model ) =
    let
        container =
            H.div [ H.style [ ( "width", "100%" ), ( "height", "100%" ), ( "background-color", "#fff" ), ( "overflow", "hidden" ) ] ]

        viewPort =
            S.svg
                [ S.width "100%"
                , S.height "100%"
                , S.viewBox <| "0 0 " ++ toString model.world.width ++ " " ++ toString model.world.height
                ]

        background =
            S.rect [ S.x "0", S.y "0", S.width "100%", S.height "100%", S.fill "#000" ] []
    in
        container
            [ viewPort
                [ background
                , Assets.pacman time model.hero
                ]
            ]
