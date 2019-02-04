module View exposing (view)

import Animation
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes exposing (class)
import Icons
import Messages exposing (Message(..))
import Model exposing (BirdData, Model)
import Svg exposing (foreignObject, svg)
import Svg.Attributes exposing (xmlSpace)


view : Model -> Browser.Document Message
view model =
    { title = "Bird Tinder"
    , body = [ layout model |> Element.layout [] ]
    }


colors =
    { background = rgb255 229 198 45 }


layout : Model -> Element Message
layout model =
    let
        currentBird =
            List.head model.remainingBirds
    in
    column
        [ width (fill |> maximum 320)
        , height (fill |> maximum 480)
        , centerX
        , centerY
        , Background.color colors.background
        , scrollbarY
        , clipX
        ]
    <|
        [ -- header
          row
            [ width fill
            , height (px 40)
            ]
            []
        , column
            [ width fill
            , height
                (if model.detailedView then
                    px 250

                 else
                    fill
                )

            -- detail view button
            , inFront <|
                if model.detailedView then
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
        , --footer
          column
            [ height
                (if model.detailedView then
                    fill

                 else
                    px 50
                )
            , width fill
            , paddingEach
                { top = 0
                , bottom = 20
                , left = 0
                , right = 0
                }
            , spacing 20
            , inFront
                (row
                    [ alignBottom
                    , centerX
                    , spacing 20
                    , moveUp 10
                    ]
                    [ Input.button
                        [ width (px 40)
                        , height (px 40)
                        , Background.color (rgb 1 1 1)
                        , Border.rounded 100
                        , Border.glow (rgb 0.8 0.8 0.8) 2
                        ]
                        { onPress = Just BirdDismissed
                        , label = Icons.ex
                        }
                    , Input.button
                        [ width (px 40)
                        , height (px 40)
                        , Background.color (rgb 1 1 1)
                        , Border.rounded 100
                        , Border.glow (rgb 0.8 0.8 0.8) 2
                        ]
                        { onPress = Just BirdLiked
                        , label = Icons.heart
                        }
                    ]
                )
            ]
            [ if model.detailedView then
                case currentBird of
                    Just bird ->
                        column [ width fill ]
                            [ column
                                [ spacing 10
                                , width fill
                                , paddingXY 0 20
                                , Border.widthEach
                                    { bottom = 1
                                    , top = 0
                                    , left = 0
                                    , right = 0
                                    }
                                , Border.solid
                                , Border.color (rgb 0 0 0)
                                ]
                                [ el [ Font.size 28, paddingXY 20 0 ] (text bird.name)
                                , el [ Font.size 18, paddingXY 20 0 ] (text bird.location)
                                , el [ Font.size 18, paddingXY 20 0 ] (text bird.distance)
                                ]
                            , column
                                [ spacing 10
                                , width fill
                                , paddingXY 0 20
                                , height
                                    (fill
                                        |> minimum 80
                                    )
                                ]
                                [ el [ Font.size 18, paddingXY 20 0 ] (text bird.name)
                                ]
                            ]

                    Nothing ->
                        none

              else
                none
            ]
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
                        , Border.color colors.background
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
