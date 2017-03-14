module Game exposing (..)

import Types exposing (..)


startGame : Game -> Game
startGame game =
    let
        allPlayers =
            game.players
                |> List.indexedMap
                    (\i player ->
                        (if i == 0 then
                            { player | go = Just (Go 3) }
                         else
                            player
                        )
                    )
    in
        { game | players = allPlayers }
