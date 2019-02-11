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
        , height
            (if model.detailedView then
                px 0

             else
                px 40
            )
        , spaceEvenly
        ]
        [ Input.button
            [ width (px 30)
            , height (px 30)
            , centerY
            , alignLeft
            , moveRight 20
            , moveDown 5
            ]
            { onPress = Nothing
            , label = Icons.profile
            }
        , Input.button
            [ width (px 30)
            , height (px 30)
            , centerY
            , centerX
            ]
            { onPress = Nothing
            , label = Icons.pecker
            }
        , Input.button
            [ width (px 30)
            , height (px 30)
            , centerY
            , alignRight
            , moveLeft 20
            , moveDown 5
            ]
            { onPress = Just MessageScreenButtonClicked
            , label = Icons.message
            }
        ]
