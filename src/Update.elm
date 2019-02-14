module Update exposing (update)

import Animation
import Animation.Messenger
import List.Extra as List
import Messages exposing (..)
import Model exposing (..)
import Model.Animations
import Model.Types exposing (..)
import Model.Types.BirdData exposing (..)
import Time exposing (Posix)
import Update.Animations


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        TimeZoneReceived zone ->
            ( { model | timeZone = zone }, Cmd.none )

        CurrentTimeReceived time ->
            let
                modelWithUpdatedTime =
                    { model | currentTime = time }
            in
            if Time.posixToMillis time - Time.posixToMillis model.lastMessageTime > 5000 then
                case model.messageQueue of
                    [] ->
                        ( modelWithUpdatedTime, Cmd.none )

                    top :: rest ->
                        ( { modelWithUpdatedTime
                            | messageQueue = rest
                            , messages = addToMessages time top model.messages
                            , lastMessageTime = time
                          }
                        , Cmd.none
                        )

            else
                ( modelWithUpdatedTime, Cmd.none )

        WindowSizeInformationReceived width height ->
            ( model
                |> Model.setDimensions { width = toFloat width, height = toFloat height }
            , Cmd.none
            )

        Animate msg ->
            Update.Animations.update msg model

        BirdDismissed ->
            if model.cardAnimating then
                ( model, Cmd.none )

            else
                ( { model | detailedView = False }
                    |> Model.Animations.animateLeftSwipe
                , Cmd.none
                )

        BirdLiked ->
            if model.cardAnimating then
                ( model, Cmd.none )

            else
                ( { model | detailedView = False }
                    |> Model.Animations.animateRightSwipe
                , Cmd.none
                )

        BirdDismissalCompleted ->
            case model.remainingBirds of
                top :: rest ->
                    ( { model
                        | remainingBirds = rest
                        , dislikedBirds = top :: model.likedBirds
                        , topCardStyle = Model.Animations.initCardStyle
                        , cardAnimating = False
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        BirdLikeCompleted ->
            case model.remainingBirds of
                top :: rest ->
                    let
                        birdMessages =
                            top.message
                                |> String.split "//"
                                |> List.filter (not << String.isEmpty)
                                |> List.map (\s -> BirdMessage top.name s)
                    in
                    ( { model
                        | remainingBirds = rest
                        , likedBirds = top :: model.likedBirds
                        , topCardStyle = Model.Animations.initCardStyle
                        , cardAnimating = False
                        , messageQueue = List.interweave model.messageQueue birdMessages
                        , matchNotification =
                            if List.isEmpty birdMessages then
                                Nothing

                            else
                                Just top
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        DetailOpenClicked ->
            ( { model | detailedView = True }, Cmd.none )

        DetailCloseClicked ->
            ( { model | detailedView = False }, Cmd.none )

        IntroAnimationCompleted ->
            ( Model.Animations.screenTransition Match model
            , Cmd.none
            )

        MessageScreenButtonClicked ->
            ( Model.Animations.screenTransition Messages model
            , Cmd.none
            )

        MatchScreenButtonClicked ->
            ( Model.Animations.screenTransition Match model
            , Cmd.none
            )

        MessageHistoryClicked history ->
            ( { model
                | messages =
                    model.messages
                        |> List.map
                            (\h ->
                                if h.birdName == history.birdName then
                                    { h
                                        | messages = List.map (\m -> { m | unread = False }) h.messages
                                    }

                                else
                                    h
                            )
              }
                |> Model.Animations.screenTransition (MessageHistory history.birdName)
            , Cmd.none
            )

        ScreenClicked ->
            ( { model | matchNotification = Nothing }
            , Cmd.none
            )

        BirdsRandomized birds ->
            ( { model | remainingBirds = birds }
            , Cmd.none
            )


addToMessages : Posix -> BirdMessage -> List BirdMessageHistory -> List BirdMessageHistory
addToMessages time { birdName, message } histories =
    let
        newMessage =
            { text = message
            , unread = True
            , timestamp = time
            }
    in
    case List.partition (\history -> history.birdName == birdName) histories of
        ( [], _ ) ->
            BirdMessageHistory birdName [ newMessage ] :: histories

        ( found :: _, rest ) ->
            { found | messages = newMessage :: found.messages } :: rest
