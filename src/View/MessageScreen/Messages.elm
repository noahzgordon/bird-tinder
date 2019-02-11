module View.MessageScreen.Messages exposing (view)

import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Messages exposing (..)
import Model exposing (BirdData, BirdMessage, Model)


view : Model -> Element Message
view model =
    column
        [ paddingXY 20 30 ]
        ([ el [ Font.color Colors.red, Font.bold ]
            (text "Messages")
         ]
            ++ drawMessages model
        )


drawMessages : Model -> List (Element Message)
drawMessages model =
    case model.messages of
        [] ->
            [ text "You don't have any messages yet!" ]

        messages ->
            List.map drawMessage messages


drawMessage : BirdMessage -> Element Message
drawMessage { birdName, message } =
    row []
        [ text birdName
        , text " // "
        , text message
        ]
