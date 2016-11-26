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
            { model | hero = moveHero time model.world model.hero }
    in
        ( ( time, updatedModel ), Cmd.none )


moveHero : Time.Time -> Model.World -> Model.Hero -> Model.Hero
moveHero time world hero =
    let
        updatedHero =
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
    in
        updatedHero
            |> checkBoundaries world


checkBoundaries : Model.World -> Model.Hero -> Model.Hero
checkBoundaries world hero =
    if hero.position.x < 0 then
        { hero
            | position =
                { x = world.width - hero.radius * 2
                , y = hero.position.y
                }
        }
    else if hero.position.y < 0 then
        { hero
            | position =
                { x = hero.position.x
                , y = world.height - hero.radius * 2
                }
        }
    else if hero.position.x + hero.radius * 2 > world.width then
        { hero
            | position =
                { x = 0
                , y = hero.position.y
                }
        }
    else if hero.position.y + hero.radius * 2 > world.height then
        { hero
            | position =
                { x = hero.position.x
                , y = 0
                }
        }
    else
        hero


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
