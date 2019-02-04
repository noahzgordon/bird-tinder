module View exposing (view)

import Animation
import Browser
import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes exposing (class)
import Icons
import Messages exposing (Message(..))
import Model exposing (BirdData, Model)
import Svg exposing (foreignObject, svg)
import Svg.Attributes exposing (xmlSpace)
import View.MatchScreen


view : Model -> Browser.Document Message
view model =
    { title = "Bird Tinder"
    , body = [ layout model |> Element.layout [] ]
    }


layout : Model -> Element Message
layout model =
    el
        -- screen
        [ width (px 320)
        , height (px 480)
        , centerX
        , centerY
        , Background.color Colors.background
        , clip
        ]
    <|
        row [ width (px 640), height fill ]
            [ View.MatchScreen.view model ]
