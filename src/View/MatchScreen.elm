module View.MatchScreen exposing (view)

import Element exposing (..)
import Messages exposing (Message)
import Model.Types exposing (Model)
import View.MatchScreen.Footer as Footer
import View.MatchScreen.Header as Header
import View.MatchScreen.Picture as Picture


view : Model -> Element Message
view model =
    el
        ([ width (px <| round model.windowDimensions.width)
         , height (px <| round model.windowDimensions.height)
         , scrollbarY
         , clipX
         ]
            ++ (if model.cardAnimating then
                    [ clip ]

                else
                    [ clipX, scrollbarY ]
               )
        )
        (column
            [ width fill, height fill ]
            [ Header.view model
            , Picture.view model
            , Footer.view model
            ]
        )
