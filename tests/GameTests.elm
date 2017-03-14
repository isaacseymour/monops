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
                    expected =
                        Game.startGame gameWithTwoPlayers
                            |> .players
                            |> List.map .go
                in
                    Expect.equal [ Just (Go 3), Nothing ] expected
        , test "it draws 5 cards for each player" <|
            \() ->
                let
                    newGame =
                        Game.startGame gameWithTwoPlayers

                    playerCardCounts =
                        newGame.players
                            |> List.map .hand
                            |> List.map List.length
                in
                    Expect.equal [ 5, 5 ] playerCardCounts
        , test "it leaves all the other cards in the main deck" <|
            \() ->
                let
                    newGame =
                        Game.startGame gameWithTwoPlayers

                    drawPileCount =
                        Maybe.map (List.length) newGame.drawPile
                in
                    -- 106 cards - 5 per player = 96 left in drawPile
                    Expect.equal (Just 96) drawPileCount
        ]
