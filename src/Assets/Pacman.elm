module Assets.Pacman exposing (pacman)

import Svg exposing (Svg, path)
import Svg.Attributes exposing (fill, cx, cy, r, d, transform)
import Model


angle : Float
angle =
    degrees 40


mouthSpeed : Int
mouthSpeed =
    20


pacman : Float -> Model.Hero -> Svg msg
pacman time hero =
    let
        mouthAngle =
            let
                framesPerMouth =
                    round (Model.frameConstant / toFloat mouthSpeed)

                mod =
                    round time % framesPerMouth + 1

                halfSpeed =
                    toFloat framesPerMouth / 2

                moveAngle =
                    if mod < round halfSpeed then
                        (toFloat mod / halfSpeed) * angle
                    else
                        (toFloat (framesPerMouth - mod) / halfSpeed) * angle
            in
                case ( hero.move, moveAngle ) of
                    ( True, 0 ) ->
                        0.01

                    ( True, _ ) ->
                        moveAngle

                    ( False, _ ) ->
                        angle

        startX =
            toString <| hero.radius + round (toFloat hero.radius * cos mouthAngle)

        startY =
            toString <| hero.radius - round (toFloat hero.radius * sin mouthAngle)

        endX =
            startX

        endY =
            toString <| hero.radius + round (toFloat hero.radius * sin mouthAngle)

        rotation =
            case hero.direction of
                Model.Up ->
                    -90

                Model.Down ->
                    90

                Model.Left ->
                    180

                Model.Right ->
                    0

        rotate =
            "rotate(" ++ toString rotation ++ " " ++ toString hero.radius ++ " " ++ toString hero.radius ++ ")"

        translate =
            "translate(" ++ toString hero.position.x ++ " " ++ toString hero.position.y ++ ")"
    in
        path
            [ fill "#ffcc00"
            , transform <| translate ++ " " ++ rotate
            , d <|
                "M"
                    ++ startX
                    ++ ","
                    ++ startY
                    ++ " A "
                    ++ toString hero.radius
                    ++ ","
                    ++ toString hero.radius
                    ++ " 0 1,0 "
                    ++ endX
                    ++ ", "
                    ++ endY
                    ++ " L "
                    ++ toString hero.radius
                    ++ ", "
                    ++ toString hero.radius
                    ++ "Z"
            ]
            []
