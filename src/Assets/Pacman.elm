module Assets.Pacman exposing (pacman)

import Svg exposing (Svg, path)
import Svg.Attributes exposing (fill, cx, cy, r, d)


angle : Float
angle =
    degrees 40


radius : Float
radius =
    20


mouthSpeed : Int
mouthSpeed =
    300


pacman : Float -> Bool -> Svg msg
pacman time move =
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
                if move then
                    moveAngle
                else
                    angle

        startX =
            toString <| radius + (radius * cos mouthAngle)

        startY =
            toString <| radius - (radius * sin mouthAngle)

        endX =
            startX

        endY =
            toString <| radius + (radius * sin mouthAngle)
    in
        path
            [ fill "#ffcc00"
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
