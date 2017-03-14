module GameTests exposing (..)

import Test exposing (..)
import Types exposing (..)
import Expect
import Cards
import Game


makeStartPlayer : String -> Player
makeStartPlayer name =
    Player name [] [] [] Nothing


jack : Player
jack =
    makeStartPlayer "jack"


isaac : Player
isaac =
    makeStartPlayer "isaac"


gameWithTwoPlayers : Game
gameWithTwoPlayers =
    { players = [ jack, isaac ]
    , drawPile = Just (Cards.allCards)
    , discardPile = []
    }


all : Test
all =
    describe "Game logic tests"
        [ test "it gives the first player a go with 3 plays" <|
            \() ->
                let
                    expectedPlayers =
                        [ { jack | go = Just (Go 3) }
                        , isaac
                        ]
                in
                    Expect.equal expectedPlayers <| (Game.startGame gameWithTwoPlayers).players
        ]
