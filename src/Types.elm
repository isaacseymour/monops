module Types exposing (..)


type alias Money =
    Int


type Colour
    = Stations
    | Utilities
    | Green
    | Orange
    | Brown
    | LightBlue
    | Pink
    | Red
    | Yellow
    | Blue


type alias Set =
    { colour : Colour, rents : List Money }


type Card
    = Cash Money
    | Property Set Money
    | TwoProperty { activeSet : Maybe Set, sets : ( Set, Set ) } Money
    | WildProperty (Maybe Set)
    | DealBreaker
    | Birthday
    | Rent Set Set Money
    | MultiRent Money
    | DoubleRent
    | JustSayNo
    | DebtCollector
    | PassGo
    | ForceDeal
    | SlyDeal
    | House
    | Hotel


type alias Player =
    { name : String
    , hand : List Card
    , propertySets : List Card
    , money : List Card
    , go : Maybe Go
    }


type alias Go =
    { cardsRemaining : Int }


type alias Game =
    { players : List Player
    , drawPile : Maybe (List Card)
    , discardPile : List Card
    }


type alias Model =
    { game : Game
    , pendingPlayerName : String
    }
