module Properties exposing (..)

import Types exposing (..)
import Sets


all : List Card
all =
    [ oranges
    , greens
    , utilities
    , lightBlues
    , stations
    , pinks
    , reds
    , yellows
    , browns
    , blues
    , wildcards
    , List.repeat 2 (WildProperty Nothing)
    ]
        |> List.concat


oranges : List Card
oranges =
    [ "Marlborough Street", "Vine Street", "Bow Street" ]
        |> makeSet Sets.orange 2


greens : List Card
greens =
    [ "Bond Street", "Oxford Street", "Regent Street" ]
        |> makeSet Sets.green 4


utilities : List Card
utilities =
    [ "Electric Company", "Waterworks" ]
        |> makeSet Sets.utilities 2


lightBlues : List Card
lightBlues =
    [ "The Angel, Islington", "Pentonville Road", "Euston Road" ]
        |> makeSet Sets.lightBlue 1


stations : List Card
stations =
    [ "Marylebone Station", "Liverpool St. Station", "Kings Cross", "Fenchurch St." ]
        |> makeSet Sets.stations 2


yellows : List Card
yellows =
    [ "Coventry Street", "Leicester Square", "Piccadilly Circus" ]
        |> makeSet Sets.yellow 3


blues : List Card
blues =
    [ "Park Lane", "Mayfair" ]
        |> makeSet Sets.blue 4


browns : List Card
browns =
    [ "Whitechapel Road", "Old Kent Road" ]
        |> makeSet Sets.brown 1


reds : List Card
reds =
    [ "Strand", "Trafalgar Square", "Fleet Street" ]
        |> makeSet Sets.red 3


pinks : List Card
pinks =
    [ "Pall Mall", "Northumberland Avenue", "Whitehall" ]
        |> makeSet Sets.pink 2


wildcards : List Card
wildcards =
    [ ( 1, ( Sets.stations, Sets.utilities ), 4 )
    , ( 2, ( Sets.yellow, Sets.red ), 3 )
    , ( 1, ( Sets.brown, Sets.lightBlue ), 1 )
    , ( 2, ( Sets.pink, Sets.orange ), 2 )
    , ( 1, ( Sets.green, Sets.stations ), 3 )
    , ( 1, ( Sets.green, Sets.blue ), 3 )
    ]
        |> List.concatMap
            (\( count, sets, value ) ->
                (List.repeat count (makeTwoProperty sets value))
            )


makeSet : Set -> Money -> List String -> List Card
makeSet set value names =
    List.map (\name -> Property name set value) names


makeTwoProperty : ( Set, Set ) -> Money -> Card
makeTwoProperty sets value =
    TwoProperty (TwoPropertyData Nothing sets) value
