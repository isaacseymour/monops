module PlayerView exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


renderInactivePlayer : Player -> Html Msg
renderInactivePlayer player =
    li [ class "inactive-player" ]
        [ h5 [] [ text player.name ]
        ]


renderActivePlayer : Player -> Html Msg
renderActivePlayer player =
    let
        goesLeft =
            player.go
                |> Maybe.map .cardsRemaining
                |> Maybe.withDefault 0
    in
        li [ class "active-player" ]
            [ h5 [] [ text player.name ]
            , text ("Goes left: " ++ (toString goesLeft))
            ]


renderPlayer : Player -> Html Msg
renderPlayer player =
    case player.go of
        Nothing ->
            renderInactivePlayer player

        Just _ ->
            renderActivePlayer player


renderPlayers : Game -> Html Msg
renderPlayers game =
    ul [ class "players" ] <| List.map renderPlayer game.players
