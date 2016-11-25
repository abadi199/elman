module Msg exposing (Msg(..))

import Time
import Keyboard


type Msg
    = TimeUpdated Time.Time
    | KeyPressed Keyboard.KeyCode
