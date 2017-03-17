module GoView exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


renderCard : Card -> Html Msg
renderCard card =
    case card of
        Cash value ->
            li [] [ text <| "Cash: " ++ (toString value) ]

        Property name set value ->
            li [] [ text <| "Property: " ++ name ]

        TwoProperty { sets } value ->
            li []
                [ [ "Two Property:"
                  , toString <| .colour <| (Tuple.first sets)
                  , toString <| .colour <| (Tuple.second sets)
                  ]
                    |> String.join " "
                    |> text
                ]

        WildProperty _ ->
            li [] [ text <| "Wildcard Property" ]

        Rent set1 set2 ->
            li []
                [ [ "Rent card:"
                  , toString <| .colour <| set1
                  , toString <| .colour <| set2
                  ]
                    |> String.join " "
                    |> text
                ]

        val ->
            li [] [ text (toString val) ]


renderHand : List Card -> Html Msg
renderHand cards =
    ul [ class "player-hand" ]
        (List.map renderCard cards)


renderCurrentGo : Player -> Html Msg
renderCurrentGo player =
    case player.go of
        Just { cardsRemaining, hasDrawn } ->
            div [ class "current-go" ]
                [ button [ onClick (DrawCards player), disabled hasDrawn ] [ text "Draw from deck" ]
                , h5 []
                    [ text <| "Current cards left to play: " ++ (toString cardsRemaining)
                    ]
                , renderHand player.hand
                ]

        Nothing ->
            text ""
