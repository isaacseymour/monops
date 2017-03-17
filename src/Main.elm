module Main exposing (..)

import App exposing (..)
import Types exposing (Model, Msg)
import Html exposing (program)


main : Program Never Model Msg
main =
    program { view = view, init = initGameWithTwoPlayers, update = update, subscriptions = subscriptions }
