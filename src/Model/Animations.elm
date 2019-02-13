module Model.Animations exposing (animateLeftSwipe, animateRightSwipe, initCardStyle, initScreenStyle, swipeAnimation)

import Animation
import Animation.Messenger
import Messages exposing (..)
import Model.Types exposing (..)


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
