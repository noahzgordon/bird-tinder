module View.MatchScreen exposing (view)

import Element exposing (..)
import Messages exposing (Message)
import Model exposing (Model)
import View.MatchScreen.Footer as Footer
import View.MatchScreen.Header as Header
import View.MatchScreen.Picture as Picture


view : Model -> Element Message
view model =
    column [ width (px 320), height fill ]
        [ Header.view model
        , Picture.view model
        , Footer.view model
        ]
