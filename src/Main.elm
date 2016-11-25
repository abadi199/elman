module Main exposing (main)

import AnimationFrame
import Time exposing (Time)
import Model exposing (Model)
import Msg exposing (Msg)
import View
import Update
import Html as H
import Keyboard


main : Program Never ( Time, Model ) Msg
main =
    H.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }


init : ( ( Time, Model ), Cmd Msg )
init =
    ( ( 0, { move = False, direction = Model.Left } ), Cmd.none )


subscriptions : ( Time, Model ) -> Sub Msg
subscriptions ( _, model ) =
    Sub.batch
        [ AnimationFrame.times Msg.TimeUpdated
        , Keyboard.presses Msg.KeyPressed
        ]
