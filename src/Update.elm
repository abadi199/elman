module Update exposing (update)

import Msg exposing (Msg)
import Model exposing (Model)
import Time
import Keyboard
import KeyCode


update : Msg -> ( Time.Time, Model ) -> ( ( Time.Time, Model ), Cmd Msg )
update msg ( time, model ) =
    case msg of
        Msg.TimeUpdated updatedTime ->
            updateTime updatedTime model

        Msg.KeyPressed keyCode ->
            changeDirection keyCode time model


updateTime : Time.Time -> Model -> ( ( Time.Time, Model ), Cmd Msg )
updateTime time model =
    ( ( time, model ), Cmd.none )


changeDirection : Keyboard.KeyCode -> Time.Time -> Model -> ( ( Time.Time, Model ), Cmd Msg )
changeDirection keyCode time model =
    let
        updatedDirection =
            if keyCode == KeyCode.left then
                Model.Left
            else if keyCode == KeyCode.right then
                Model.Right
            else if keyCode == KeyCode.up then
                Model.Up
            else if keyCode == KeyCode.down then
                Model.Down
            else
                Model.Left

        updatedModel =
            { model | direction = updatedDirection, move = True }
    in
        ( ( time, updatedModel ), Cmd.none )
