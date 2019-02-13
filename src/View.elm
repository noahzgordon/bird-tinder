module View exposing (view)

import Animation
import Browser
import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes exposing (class)
import Icons
import Messages exposing (Message(..))
import Model.Types exposing (Model)
import Model.Types.BirdData exposing (BirdData)
import Svg exposing (foreignObject, svg)
import Svg.Attributes exposing (xmlSpace)
import View.IntroScreen
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
        [ width fill
        , height fill
        , Background.color Colors.gray
        , onClick ScreenClicked
        ]
    <|
        el
            -- screen
            [ width (px <| round model.windowDimensions.width)
            , height (px <| round model.windowDimensions.height)
            , centerX
            , centerY
            , Background.color Colors.background
            , clip
            , inFront
                (case model.matchNotification of
                    Nothing ->
                        none

                    Just birdData ->
                        el
                            [ centerX
                            , centerY
                            , width (px 200)
                            , height (px 200)
                            , Border.solid
                            , Border.rounded 20
                            , Border.glow Colors.transBlack 5
                            , Background.color Colors.transBlack
                            ]
                        <|
                            column [ width fill, height fill, Font.color Colors.white, spacing 10 ]
                                [ el [ centerX, centerY ] <|
                                    text "It's a match!"
                                , image [ centerX, centerY, width (px 100), Border.solid, Border.rounded 20 ]
                                    { src = birdData.image, description = "" }
                                , el [ centerX, centerY ] <|
                                    text birdData.name
                                ]
                )
            ]
        <|
            el
                (List.concat
                    [ [ height fill ]
                    , List.map htmlAttribute (Animation.render model.screenStyle)
                    ]
                )
            <|
                column []
                    [ row []
                        [ View.IntroScreen.view model ]
                    , row []
                        [ View.MatchScreen.view model
                        , View.MessageScreen.view model
                        , View.MessageHistory.view model
                        ]
                    ]
