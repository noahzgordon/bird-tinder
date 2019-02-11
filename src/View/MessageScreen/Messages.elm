module View.MessageScreen.Messages exposing (view)

import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Messages exposing (..)
import Model exposing (BirdData, BirdMessage, BirdMessageHistory, Model)


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
            column [ paddingXY 0 20 ] (List.map drawMessage messages)


drawMessage : BirdMessageHistory -> Element Message
drawMessage { birdName, messages } =
    row []
        [ text birdName
        , text " // "
        , text
            (case List.head messages of
                Nothing ->
                    ""

                Just m ->
                    m
            )
        ]
