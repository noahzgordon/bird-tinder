module View.MessageScreen.Messages exposing (view)

import BirdData exposing (..)
import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import Messages exposing (..)
import Model exposing (Model)
import Time exposing (toHour, toMinute)


view : Model -> Element Message
view model =
    column
        [ paddingXY 20 30, width fill ]
        [ el [ Font.color Colors.red, Font.bold ]
            (text "Messages")
        , drawMessages model
        ]


drawMessages : Model -> Element Message
drawMessages model =
    case model.messages of
        [] ->
            paragraph [ paddingXY 0 20 ] [ text "You don't have any messages yet!" ]

        messages ->
            column [ paddingXY 0 20 ] (List.map (drawMessage model.timeZone) messages)


drawMessage : Time.Zone -> BirdMessageHistory -> Element Message
drawMessage timeZone history =
    row [ onClick (MessageHistoryClicked history) ]
        [ text history.birdName
        , text " // "
        , text
            (case List.head history.messages of
                Nothing ->
                    ""

                Just m ->
                    String.fromInt (toHour timeZone m.timestamp) ++ ":" ++ String.fromInt (toMinute timeZone m.timestamp) ++ ": " ++ m.text
            )
        ]
