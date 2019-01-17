module Subscriptions exposing (subscriptions)

import Messages exposing (Message)
import Model exposing (Model)


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none
