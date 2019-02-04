module View.MatchScreen.Header exposing (view)

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
        , height (px 40)
        ]
        [ Input.button
            [ width (px 30)
            , height (px 30)
            , Background.color (rgb 1 1 1)
            , Border.rounded 100
            , centerY
            , alignRight
            , moveLeft 20
            , moveDown 5
            ]
            { onPress = Just MessageScreenButtonClicked
            , label = Icons.retract
            }
        ]
