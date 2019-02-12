module View exposing (view)

import Animation
import BirdData exposing (BirdData)
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
import Model exposing (Model)
import Svg exposing (foreignObject, svg)
import Svg.Attributes exposing (xmlSpace)
import View.MatchScreen
import View.MessageHistory
import View.MessageScreen


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
        row
            (List.concat
                [ [ width (px 640)
                  , height fill
                  ]
                , List.map htmlAttribute (Animation.render model.screenStyle)
                ]
            )
            [ View.MatchScreen.view model
            , View.MessageScreen.view model
            , View.MessageHistory.view model
            ]
