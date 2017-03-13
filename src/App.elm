module App exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


initGame : Game
initGame =
    { players = [], drawPile = Nothing, discardPile = [] }


init : ( Model, Cmd Msg )
init =
    ( { game = initGame, pendingPlayerName = "" }, Cmd.none )


type Msg
    = AddPlayer
    | PlayerInputChange String
    | StartGame


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddPlayer ->
            ( addPlayer model, Cmd.none )

        PlayerInputChange name ->
            ( { model | pendingPlayerName = name }, Cmd.none )

        StartGame ->
            ( { model | game = startGame model.game }, Cmd.none )


startGame : Game -> Game
startGame game =
    { game | drawPile = Just [ Cash 5 ] }


addPlayer : Model -> Model
addPlayer model =
    let
        game =
            model.game

        player =
            { name = model.pendingPlayerName
            , hand = []
            , propertySets = []
            , money = []
            , go = Nothing
            }

        newGame =
            { game | players = player :: game.players }
    in
        { model | game = newGame, pendingPlayerName = "" }


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit AddPlayer ]
            [ input [ type_ "text", onInput PlayerInputChange, value model.pendingPlayerName ] []
            , button [ type_ "submit" ] [ text "Add Player" ]
            ]
        , div [] (List.map showPlayer model.game.players)
        ]


showPlayer : Player -> Html Msg
showPlayer player =
    p [] [ text player.name ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
