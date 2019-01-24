module Subscriptions exposing (subscriptions)

import Animation
import Messages exposing (Message(..))
import Model exposing (Model)


subscriptions : Model -> Sub Message
subscriptions model =
    Animation.subscription AnimateTopCard [ model.topCardStyle ]
