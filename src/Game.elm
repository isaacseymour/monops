module Game exposing (..)

import Types exposing (..)
import List.Extra


setUpFirstGo : List Player -> List Player
setUpFirstGo players =
    players
        |> List.indexedMap
            (\i player ->
                (if i == 0 then
                    { player | go = Just (Go 3) }
                 else
                    player
                )
            )


givePlayersStartingHand : List Card -> List Player -> List Player
givePlayersStartingHand cards players =
    let
        groupedCards =
            List.Extra.greedyGroupsOf 5 cards
    in
        players
            |> List.indexedMap
                (\i player ->
                    ({ player | hand = (List.Extra.getAt i groupedCards) |> Maybe.withDefault [] })
                )


dropCardsFromDrawPile : Game -> Game
dropCardsFromDrawPile game =
    let
        cardsToDrop =
            List.length game.players * 5

        newDrawPile =
            Maybe.map (List.drop cardsToDrop) game.drawPile
    in
        { game | drawPile = newDrawPile }


startGame : Game -> Game
startGame game =
    let
        allPlayers =
            setUpFirstGo game.players

        cards =
            game.drawPile |> Maybe.withDefault []

        playersWithHand =
            givePlayersStartingHand cards allPlayers

        newGame =
            { game | players = playersWithHand }
    in
        dropCardsFromDrawPile newGame
