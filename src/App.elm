module App exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import GameView
import Cards
import Random.List
import Random
import Game


initGame : Game
initGame =
    { players = [], drawPile = Nothing, discardPile = [] }


init : ( Model, Cmd Msg )
init =
    ( { game = initGame, pendingPlayerName = "" }, Cmd.none )


shuffleDeck : List Card -> Cmd Msg
shuffleDeck cards =
    Random.List.shuffle cards
        |> Random.generate ShuffledDeck


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddPlayer ->
            let
                newModel =
                    addPlayer model

                hasMaxPlayers =
                    List.length newModel.game.players == 5
            in
                if hasMaxPlayers then
                    update StartGame newModel
                else
                    ( newModel, Cmd.none )

        PlayerInputChange name ->
            ( { model | pendingPlayerName = name }, Cmd.none )

        ShuffledDeck newCards ->
            let
                game =
                    model.game

                newGame =
                    Game.startGame { game | drawPile = Just newCards }
            in
                ( { model | game = newGame }, Cmd.none )

        StartGame ->
            let
                game =
                    model.game

                newGame =
                    { game | drawPile = Just Cards.allCards }
            in
                ( { model | game = newGame }, shuffleDeck (newGame.drawPile |> Maybe.withDefault []) )


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


addPlayersView : Model -> Html Msg
addPlayersView model =
    case model.game.drawPile of
        Just _ ->
            text ""

        Nothing ->
            div []
                [ Html.form [ onSubmit AddPlayer ]
                    [ input [ type_ "text", onInput PlayerInputChange, value model.pendingPlayerName ] []
                    , button [ type_ "submit" ] [ text "Add Player" ]
                    ]
                , button [ onClick StartGame, disabled (List.length model.game.players < 2) ] [ text "Start the game" ]
                ]


gameView : Game -> Html Msg
gameView game =
    case game.drawPile of
        Nothing ->
            text "The game has not started"

        Just _ ->
            GameView.viewActiveGame game


view : Model -> Html Msg
view model =
    div []
        [ addPlayersView model
        , ul [ class "players-list" ] (List.map showPlayer model.game.players)
        , gameView model.game
        ]


showPlayer : Player -> Html Msg
showPlayer player =
    li [] [ text player.name ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
