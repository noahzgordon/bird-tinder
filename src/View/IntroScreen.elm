module View.IntroScreen exposing (view)

import Animation
import Element exposing (..)
import Element.Font as Font
import Messages exposing (Message)
import Model.Types exposing (Model)


view : Model -> Element Message
view model =
    el
        [ width (px <| round model.windowDimensions.width)
        , height (px <| round model.windowDimensions.height)
        , clip
        ]
        (el
            ([ centerY
             , centerX
             , Font.size 36
             , Font.family
                [ Font.typeface "Comic Sans MS"
                , Font.typeface "cursive"
                , Font.sansSerif
                ]
             ]
                ++ List.map htmlAttribute (Animation.render model.introTitleStyle)
            )
         <|
            text "BIRD TINDER"
        )
