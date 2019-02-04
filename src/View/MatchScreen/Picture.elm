module View.MatchScreen.Picture exposing (view)

import Animation
import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes exposing (class)
import Icons
import Messages exposing (..)
import Model exposing (BirdData, Model)


view : Model -> Element Message
view model =
    column
        [ width fill
        , height
            (if model.detailedView then
                px 250

             else
                fill
            )

        -- detail view button
        , inFront <|
            if List.isEmpty model.remainingBirds then
                none

            else if model.detailedView then
                Input.button
                    [ width (px 30)
                    , height (px 30)
                    , Background.color (rgb 1 1 1)
                    , Border.rounded 100
                    , Border.glow (rgb 0.8 0.8 0.8) 2
                    , alignBottom
                    , alignRight
                    , moveUp 30
                    , moveLeft 20
                    , htmlAttribute (class "cardfront")
                    ]
                    { onPress = Just DetailCloseClicked
                    , label = Icons.retract
                    }

            else
                Input.button
                    [ width (px 30)
                    , height (px 30)
                    , Background.color (rgb 1 1 1)
                    , Border.rounded 100
                    , Border.glow (rgb 0.8 0.8 0.8) 2
                    , alignBottom
                    , alignRight
                    , moveUp 30
                    , moveLeft 20
                    , htmlAttribute (class "cardfront")
                    ]
                    { onPress = Just DetailOpenClicked
                    , label = Icons.info
                    }
        ]
        [ html <|
            Html.div [] <|
                List.indexedMap
                    (\idx bird ->
                        let
                            htmlAttrs =
                                if idx == (List.length model.remainingBirds - 1) then
                                    Animation.render model.topCardStyle ++ [ Html.Attributes.class "top-card" ]

                                else if idx == List.length model.remainingBirds - 2 then
                                    [ Html.Attributes.class "next-card" ]

                                else
                                    [ Html.Attributes.class "other-card" ]
                        in
                        Html.div htmlAttrs
                            [ Element.layoutWith
                                { options = [ noStaticStyleSheet ] }
                                []
                                (card (not model.detailedView) bird [])
                            ]
                    )
                    (List.reverse model.remainingBirds)
                    ++ [ Html.div [ Html.Attributes.class "no-more" ] [ Html.text "We can't find any more birds near you! Try again later." ] ]
        ]


card : Bool -> BirdData -> List (Attribute Message) -> Element Message
card showInfo bird htmlAttrs =
    el
        (List.concat
            [ htmlAttrs
            , [ width fill
              , height fill
              , padding 10
              , behindContent
                    (el
                        [ height fill
                        , width fill
                        , spacing 10
                        , Background.image bird.image
                        , Border.width 10
                        , Border.color Colors.background
                        , Border.rounded 20
                        , Border.solid
                        ]
                        none
                    )
              ]
            ]
        )
    <|
        if showInfo then
            column
                [ alignBottom
                , Font.color (rgb 1 1 1)
                , Font.glow (rgb 0 0 0) 1
                , padding 10
                , spacing 5
                ]
                [ el [ Font.size 28 ] (text bird.name)
                , el [ Font.size 18 ] (text bird.location)
                , el [ Font.size 18 ] (text bird.distance)
                ]

        else
            none
