module Game exposing (..)

import Types exposing (..)
import List.Extra


setUpFirstGo : List Player -> List Player
setUpFirstGo players =
    players
        |> List.indexedMap
            (\i player ->
                (if i == 0 then
                    { player | go = Just (Go 3 False) }
                 else
                    player
                )
            )


drawCardsForPlayer : Player -> Game -> Game
drawCardsForPlayer player game =
    game


giveCardsToPlayer : List Card -> Player -> ( List Card, Player )
giveCardsToPlayer cards player =
    let
        ( playerCards, drawCards ) =
            List.Extra.splitAt 5 cards
    in
        ( drawCards, { player | hand = playerCards } )


giveCardsToPlayers : List Card -> List Player -> ( List Card, List Player )
giveCardsToPlayers cards players =
    List.foldl
        (\player ( latestCards, players ) ->
            (let
                ( newCards, newPlayer ) =
                    giveCardsToPlayer latestCards player
             in
                ( newCards, List.append players [ newPlayer ] )
            )
        )
        ( cards, [] )
        players


startGame : Game -> Game
startGame game =
    let
        allPlayers =
            setUpFirstGo game.players

        cards =
            game.drawPile |> Maybe.withDefault []

        ( finalDrawPile, finalPlayers ) =
            giveCardsToPlayers cards allPlayers
    in
        { game | players = finalPlayers, drawPile = Just finalDrawPile }
