module View.Pacman exposing (pacman)

import Svg exposing (Svg, path)
import Svg.Attributes exposing (fill, cx, cy, r, d, transform)
import Model


angle : Float
angle =
    degrees 40


mouthSpeed : Int
mouthSpeed =
    20


pacman : Float -> Model.World -> Model.Hero -> Svg msg
pacman time world hero =
    let
        tileSize =
            Model.tileSize world

        radius =
            tileSize // 2

        mouthAngle =
            let
                framesPerMouth =
                    Model.frameConstant // mouthSpeed

                mod =
                    round time % framesPerMouth + 1

                halfSpeed =
                    framesPerMouth // 2

                moveAngle =
                    if mod < halfSpeed then
                        (toFloat mod / toFloat halfSpeed) * angle
                    else
                        ((toFloat framesPerMouth - toFloat mod) / toFloat halfSpeed) * angle
            in
                case ( hero.move, moveAngle ) of
                    ( True, _ ) ->
                        if moveAngle < 0.05 then
                            0.05
                        else
                            moveAngle

                    ( False, _ ) ->
                        angle

        startX =
            toString <| radius + round (toFloat radius * cos mouthAngle)

        startY =
            toString <| radius - round (toFloat radius * sin mouthAngle)

        endX =
            startX

        endY =
            toString <| radius + round (toFloat radius * sin mouthAngle)

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
            "rotate(" ++ toString rotation ++ " " ++ toString radius ++ " " ++ toString radius ++ ")"

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
