module Subscriptions exposing (subscriptions)

import Animation
import Messages exposing (Message(..))
import Model exposing (Model)


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [ Animation.subscription AnimateTopCard [ model.topCardStyle ]
        , Animation.subscription AnimateScreen [ model.screenStyle ]
        ]
