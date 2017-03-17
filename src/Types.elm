module Types exposing (..)


type alias Money =
    Int


type Msg
    = AddPlayer
    | PlayerInputChange String
    | StartGame
    | ShuffledDeck (List Card)
    | DrawCards Player


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


type alias TwoPropertyData =
    { activeSet : Maybe Set
    , sets : ( Set, Set )
    }


type Card
    = Cash Money
    | Property String Set Money
    | TwoProperty TwoPropertyData Money
    | WildProperty (Maybe Set)
    | DealBreaker
    | Birthday
    | Rent Set Set
    | MultiRent
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
    { cardsRemaining : Int, hasDrawn : Bool }


type alias Game =
    { players : List Player
    , drawPile : Maybe (List Card)
    , discardPile : List Card
    }


type alias Model =
    { game : Game
    , pendingPlayerName : String
    }
