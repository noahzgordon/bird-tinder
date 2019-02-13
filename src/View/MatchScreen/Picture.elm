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
import Model.Types exposing (Model)
import Model.Types.BirdData exposing (BirdData)


view : Model -> Element Message
view model =
    column
        [ width fill
        , height
            (if model.detailedView then
                px <| round <| model.windowDimensions.height * 2 / 3

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
                                        ++ (if model.cardAnimating then
                                                []

                                            else
                                                [ Html.Attributes.style "opacity" "0" ]
                                           )

                                else
                                    [ Html.Attributes.class "other-card" ]
                                        ++ (if model.cardAnimating then
                                                []

                                            else
                                                [ Html.Attributes.style "opacity" "0" ]
                                           )
                        in
                        Html.div htmlAttrs
                            [ Element.layoutWith
                                { options = [ noStaticStyleSheet ] }
                                [ clip ]
                                (card model bird [])
                            ]
                    )
                    (List.reverse model.remainingBirds)
                    ++ (if List.length model.remainingBirds <= 1 then
                            [ Html.div [ Html.Attributes.class "no-more" ] [ Html.text "We can't find any more birds near you! Try again later." ] ]

                        else
                            []
                       )
        ]


card : Model -> BirdData -> List (Attribute Message) -> Element Message
card { detailedView } bird htmlAttrs =
    el
        (List.concat
            [ htmlAttrs
            , [ width fill
              , height fill
              , padding 10
              , behindContent <|
                    el
                        [ padding
                            (if detailedView then
                                0

                             else
                                10
                            )
                        , height fill
                        , width fill
                        ]
                    <|
                        el
                            [ height fill
                            , width fill
                            , Background.image bird.image
                            , Border.rounded
                                (if detailedView then
                                    0

                                 else
                                    20
                                )
                            ]
                            none
              ]
            ]
        )
    <|
        if not detailedView then
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
