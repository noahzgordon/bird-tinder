module Update exposing (update)

import Animation
import Animation.Messenger
import Messages exposing (Message(..))
import Model exposing (Model)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AnimateTopCard animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.topCardStyle
            in
            ( { model | topCardStyle = newStyle }, cmds )

        BirdDismissed ->
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
                , showNextCard = True
                , detailedView = False
              }
            , Cmd.none
            )

        BirdLiked ->
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
                , showNextCard = True
                , detailedView = False
              }
            , Cmd.none
            )

        BirdDismissalCompleted ->
            case model.remainingBirds of
                top :: rest ->
                    ( { model
                        | remainingBirds = rest
                        , likedBirds = Debug.log "bird" top :: model.likedBirds
                        , showNextCard = False
                        , topCardStyle = Model.initCardStyle
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        BirdLikeCompleted ->
            case model.remainingBirds of
                top :: rest ->
                    ( { model
                        | remainingBirds = rest
                        , dislikedBirds = top :: model.likedBirds
                        , showNextCard = False
                        , topCardStyle = Model.initCardStyle
                      }
                    , Cmd.none
                    )

                [] ->
                    ( model, Cmd.none )

        DetailOpenClicked ->
            ( { model | detailedView = True }, Cmd.none )

        DetailCloseClicked ->
            ( { model | detailedView = False }, Cmd.none )
