module View.MatchScreen.Header exposing (view)

import Element exposing (..)
import Messages exposing (Message)
import Model exposing (Model)


view : Model -> Element Message
view model =
    row
        [ width fill
        , height (px 40)
        ]
        []
