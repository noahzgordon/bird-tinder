module View.MessageScreen exposing (view)

import Element exposing (..)
import Messages exposing (Message)
import Model exposing (Model)
import View.MessageScreen.Header as Header
import View.MessageScreen.Messages as Messages


view : Model -> Element Message
view model =
    el
        [ width (px <| round model.windowDimensions.width)
        , height (px <| round model.windowDimensions.height)
        , scrollbarY
        , clipX
        ]
        (column
            [ width fill, height fill ]
            [ Header.view model
            , Messages.view model
            ]
        )
