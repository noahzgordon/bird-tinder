module View.MessageScreen.Header exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Icons
import Messages exposing (..)
import Model exposing (Model)


view : Model -> Element Message
view model =
    row
        [ width fill
        , height
            (px 40)
        ]
        [ Input.button
            [ width (px 30)
            , height (px 30)
            , centerY
            , alignLeft
            , moveRight 20
            , moveDown 5
            ]
            { onPress = Just MatchScreenButtonClicked
            , label = Icons.pecker
            }
        , Input.button
            [ width (px 30)
            , height (px 30)
            , centerY
            , centerX
            , moveLeft 12
            , moveDown 10
            , scale 1.3
            ]
            { onPress = Nothing
            , label = Icons.message
            }
        ]
