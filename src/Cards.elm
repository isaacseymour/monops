module Cards exposing (..)

import Types exposing (..)
import Sets
import Properties


allCards : List Card
allCards =
    List.concat
        [ moneyCards
        , List.repeat 3 Birthday
        , List.repeat 2 DoubleRent
        , List.repeat 10 PassGo
        , List.repeat 3 House
        , List.repeat 2 Hotel
        , List.repeat 3 SlyDeal
        , List.repeat 3 JustSayNo
        , List.repeat 3 DebtCollector
        , List.repeat 3 ForceDeal
        , List.repeat 2 DealBreaker
        , Properties.all
        , rentCards ++ (List.repeat 3 MultiRent)
        ]


rentCards : List Card
rentCards =
    [ ( 2, (Rent Sets.green Sets.blue) )
    , ( 1, (Rent Sets.brown Sets.lightBlue) )
    , ( 2, (Rent Sets.pink Sets.orange) )
    , ( 2, (Rent Sets.red Sets.yellow) )
    , ( 2, (Rent Sets.stations Sets.utilities) )
    , ( 1, (Rent Sets.green Sets.blue) )
    ]
        |> List.concatMap (\( count, rent ) -> List.repeat count rent)


makeCardsFromTuple : ( Int, Int ) -> List Card
makeCardsFromTuple ( count, value ) =
    List.repeat count (Cash value)


moneyCards : List Card
moneyCards =
    [ ( 6, 1 ), ( 5, 2 ), ( 3, 3 ), ( 3, 4 ), ( 2, 5 ), ( 1, 10 ) ]
        |> List.concatMap makeCardsFromTuple
