module GameView exposing (viewActiveGame)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import PlayerView
import GoView
import List.Extra


activePlayer : Game -> Player
activePlayer { players } =
    (List.Extra.find
        (\{ go } ->
            case go of
                Nothing ->
                    False

                Just _ ->
                    True
        )
        players
    )
        |> Maybe.withDefault (Player "" [] [] [] Nothing)


viewActiveGame : Game -> Html Msg
viewActiveGame game =
    div [ class "game-board" ]
        [ renderDrawPile game
        , PlayerView.renderPlayers game
        , GoView.renderCurrentGo (activePlayer game)
        ]


renderDrawPile : Game -> Html Msg
renderDrawPile { drawPile } =
    case drawPile of
        Just cards ->
            div [ class "draw-pile" ]
                [ text ("Draw pile " ++ (toString <| List.length cards) ++ " cards remaining")
                ]

        Nothing ->
            text ""
