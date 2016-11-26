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
    let
        updatedModel =
            { model | hero = moveHero time model.hero }
    in
        ( ( time, updatedModel ), Cmd.none )


moveHero : Time.Time -> Model.Hero -> Model.Hero
moveHero time hero =
    if not hero.move then
        hero
    else
        case hero.direction of
            Model.Up ->
                { hero | position = { x = hero.position.x, y = hero.position.y - hero.speed } }

            Model.Down ->
                { hero | position = { x = hero.position.x, y = hero.position.y + hero.speed } }

            Model.Left ->
                { hero | position = { x = hero.position.x - hero.speed, y = hero.position.y } }

            Model.Right ->
                { hero | position = { x = hero.position.x + hero.speed, y = hero.position.y } }


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
                model.hero.direction

        hero =
            model.hero

        updatedModel =
            { model | hero = { hero | direction = updatedDirection, move = True } }
    in
        ( ( time, updatedModel ), Cmd.none )
