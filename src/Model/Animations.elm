module Model.Animations exposing (animateLeftSwipe, animateRightSwipe, initCardStyle, initIntroTitleStyle, initScreenStyle, screenTransition, swipeAnimation)

import Animation
import Animation.Messenger
import Messages exposing (..)
import Model.Types exposing (..)
import Time exposing (millisToPosix)


initCardStyle : Animation.Messenger.State Message
initCardStyle =
    Animation.style
        [ Animation.translate (Animation.px 0) (Animation.px 0)
        , Animation.rotate (Animation.deg 0)
        ]


initScreenStyle : Animation.Messenger.State Message
initScreenStyle =
    Animation.style
        [ Animation.translate (Animation.px 0) (Animation.px 0)
        ]


initIntroTitleStyle : Animation.Messenger.State Message
initIntroTitleStyle =
    Animation.style [ Animation.scale 0, Animation.rotate (Animation.deg 0) ]
        |> Animation.interrupt
            [ Animation.toWith
                (Animation.easing
                    { duration = 2000
                    , ease = (*) 1
                    }
                )
                [ Animation.scale 1.2, Animation.rotate (Animation.deg -10) ]
            , Animation.toWith
                (Animation.easing
                    { duration = 1000
                    , ease = (*) 1
                    }
                )
                [ Animation.scale 1, Animation.rotate (Animation.deg 0) ]
            , Animation.wait (millisToPosix 5000)
            , Animation.Messenger.send IntroAnimationCompleted
            ]


animateRightSwipe : Model -> Model
animateRightSwipe model =
    { model
        | topCardStyle =
            Animation.interrupt
                [ swipeAnimation (model.windowDimensions.width * 5 / 4) 20
                , Animation.Messenger.send BirdLikeCompleted
                ]
                model.topCardStyle
        , cardAnimating = True
    }


animateLeftSwipe : Model -> Model
animateLeftSwipe model =
    { model
        | topCardStyle =
            Animation.interrupt
                [ swipeAnimation (negate model.windowDimensions.width * 5 / 4) -20
                , Animation.Messenger.send BirdDismissalCompleted
                ]
                model.topCardStyle
        , cardAnimating = True
    }


swipeAnimation : Float -> Float -> Animation.Messenger.Step msg
swipeAnimation translate rotate =
    Animation.toWith
        (Animation.easing
            { duration = 500
            , ease = (*) 2
            }
        )
        [ Animation.translate (Animation.px translate) (Animation.px 0)
        , Animation.rotate (Animation.deg rotate)
        ]


screenTransition : Screen -> Model -> Model
screenTransition screen model =
    let
        ( screenX, screenY ) =
            case screen of
                Intro ->
                    ( 0, 0 )

                Match ->
                    ( 0, -1 )

                Messages ->
                    ( -1, -1 )

                MessageHistory _ ->
                    ( -2, -1 )
    in
    { model
        | currentScreen = screen
        , screenStyle =
            Animation.interrupt
                [ Animation.to
                    [ Animation.translate
                        (Animation.px <| model.windowDimensions.width * screenX)
                        (Animation.px <| model.windowDimensions.height * screenY)
                    ]
                ]
                model.screenStyle
    }
