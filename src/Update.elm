module Update exposing (update)

import Animation
import Animation.Messenger
import List.Extra as List
import Messages exposing (..)
import Model exposing (..)
import Time


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
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
                            , messages = top :: model.messages
                            , lastMessageTime = time
                          }
                        , Cmd.none
                        )

            else
                ( modelWithUpdatedTime, Cmd.none )

        AnimateTopCard animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.topCardStyle
            in
            ( { model | topCardStyle = newStyle }, cmds )

        AnimateScreen animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.screenStyle
            in
            ( { model | screenStyle = newStyle }, cmds )

        BirdDismissed ->
            if model.cardAnimating then
                ( model, Cmd.none )

            else
                ( { model
                    | topCardStyle =
                        Animation.interrupt
                            [ Animation.to
                                [ Animation.translate (Animation.px -400) (Animation.px 0)
                                , Animation.rotate (Animation.deg -20)
                                ]
                            , Animation.Messenger.send BirdDismissalCompleted
                            ]
                            model.topCardStyle
                    , detailedView = False
                    , cardAnimating = True
                  }
                , Cmd.none
                )

        BirdLiked ->
            if model.cardAnimating then
                ( model, Cmd.none )

            else
                ( { model
                    | topCardStyle =
                        Animation.interrupt
                            [ Animation.to
                                [ Animation.translate (Animation.px 400) (Animation.px 0)
                                , Animation.rotate (Animation.deg 20)
                                ]
                            , Animation.Messenger.send BirdLikeCompleted
                            ]
                            model.topCardStyle
                    , detailedView = False
                    , cardAnimating = True
                  }
                , Cmd.none
                )

        BirdDismissalCompleted ->
            case model.remainingBirds of
                top :: rest ->
                    ( { model
                        | remainingBirds = rest
                        , dislikedBirds = top :: model.likedBirds
                        , topCardStyle = Model.initCardStyle
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
                        , topCardStyle = Model.initCardStyle
                        , cardAnimating = False
                        , messageQueue = List.interweave model.messageQueue birdMessages
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        DetailOpenClicked ->
            ( { model | detailedView = True }, Cmd.none )

        DetailCloseClicked ->
            ( { model | detailedView = False }, Cmd.none )

        MessageScreenButtonClicked ->
            ( { model
                | currentScreen = Messages
                , screenStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.translate (Animation.px -320) (Animation.px 0) ]
                        ]
                        model.screenStyle
              }
            , Cmd.none
            )

        MatchScreenButtonClicked ->
            ( { model
                | currentScreen = Messages
                , screenStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.translate (Animation.px 0) (Animation.px 0) ]
                        ]
                        model.screenStyle
              }
            , Cmd.none
            )
