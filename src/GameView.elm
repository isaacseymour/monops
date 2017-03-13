module GameView exposing (viewActiveGame)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


viewActiveGame : Game -> Html Msg
viewActiveGame game =
    text "The game has started"
