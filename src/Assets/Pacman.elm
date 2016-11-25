module Assets.Pacman exposing (pacman)

import Svg exposing (Svg, path)
import Svg.Attributes exposing (fill, cx, cy, r, d, transform)
import Model


angle : Float
angle =
    degrees 40


radius : Float
radius =
    20


mouthSpeed : Int
mouthSpeed =
    300


pacman : Float -> Bool -> Model.Direction -> Svg msg
pacman time move direction =
    let
        mouthAngle =
            let
                mod =
                    round time % mouthSpeed + 1

                halfSpeed =
                    toFloat mouthSpeed / 2

                moveAngle =
                    if mod < round halfSpeed then
                        (toFloat mod / halfSpeed) * angle
                    else
                        (toFloat (mouthSpeed - mod) / halfSpeed) * angle
            in
                case ( move, moveAngle ) of
                    ( True, 0 ) ->
                        0.01

                    ( True, _ ) ->
                        moveAngle

                    ( False, _ ) ->
                        angle

        startX =
            toString <| radius + (radius * cos mouthAngle)

        startY =
            toString <| radius - (radius * sin mouthAngle)

        endX =
            startX

        endY =
            toString <| radius + (radius * sin mouthAngle)

        rotation =
            case direction of
                Model.Up ->
                    -90

                Model.Down ->
                    90

                Model.Left ->
                    180

                Model.Right ->
                    0
    in
        path
            [ fill "#ffcc00"
            , transform <| "rotate(" ++ toString rotation ++ " " ++ toString radius ++ " " ++ toString radius ++ ")"
            , d <|
                "M"
                    ++ startX
                    ++ ","
                    ++ startY
                    ++ " A "
                    ++ toString radius
                    ++ ","
                    ++ toString radius
                    ++ " 0 1,0 "
                    ++ endX
                    ++ ", "
                    ++ endY
                    ++ " L "
                    ++ toString radius
                    ++ ", "
                    ++ toString radius
                    ++ "Z"
            ]
            []
