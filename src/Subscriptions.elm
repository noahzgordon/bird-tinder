module Subscriptions exposing (subscriptions)

import Animation
import Messages exposing (Message(..))
import Model exposing (Model)
import Time


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Animation.subscription AnimateTopCard [ model.topCardStyle ]
        , Animation.subscription AnimateScreen [ model.screenStyle ]
        , Time.every 500 CurrentTimeReceived
        ]
