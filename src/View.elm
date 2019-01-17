module View exposing (view)

import Browser
import Messages exposing (Message)
import Model exposing (Model)


view : Model -> Browser.Document Message
view model =
    { title = "Bird Tinder"
    , body = []
    }
