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
    H.div [ H.style [ ( "width", "100%" ), ( "height", "100%" ), ( "background-color", "#fff" ), ( "overflow", "hidden" ) ] ]
        [ S.svg
            [ S.width "100%", S.height "100%", S.viewBox "0 0 1280 720" ]
            [ S.rect [ S.x "0", S.y "0", S.width "100%", S.height "100%", S.fill "#000" ] []
            , Assets.pacman time model.move model.direction
            ]
        ]
