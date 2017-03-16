module GameView exposing (viewActiveGame)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


viewActiveGame : Game -> Html Msg
viewActiveGame game =
    div []
        [ renderDrawPile game
        ]


renderDrawPile : Game -> Html Msg
renderDrawPile { drawPile } =
    case drawPile of
        Just cards ->
            div [ class "draw-pile" ] [ text (toString <| List.length cards) ]

        Nothing ->
            text ""
