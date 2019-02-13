module Subscriptions exposing (subscriptions)

import Animation
import Browser.Events exposing (onResize)
import Messages exposing (..)
import Model.Types exposing (Model)
import Time


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Animation.subscription (Animate << TopCard) [ model.topCardStyle ]
        , Animation.subscription (Animate << Screen) [ model.screenStyle ]
        , Animation.subscription (Animate << IntroTitle) [ model.introTitleStyle ]
        , Time.every 500 CurrentTimeReceived
        , onResize WindowSizeInformationReceived
        ]
