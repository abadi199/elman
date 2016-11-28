module Main exposing (main)

import AnimationFrame
import Time exposing (Time)
import Model exposing (Model)
import Msg exposing (Msg)
import View
import Update
import Html as H
import Keyboard
import Levels.Level1 as Level


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
    ( ( 0
      , { world = Model.world 30 Level.level1
        , hero =
            { move = False
            , direction = Model.Left
            , position =
                { x = 0
                , y = 0
                }
            , speed = 4
            }
        }
      )
    , Cmd.none
    )


subscriptions : ( Time, Model ) -> Sub Msg
subscriptions ( _, model ) =
    Sub.batch
        [ AnimationFrame.times Msg.TimeUpdated
        , Keyboard.downs Msg.KeyPressed
        ]
