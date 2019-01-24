module View exposing (view)

import Animation
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes
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
    column
        [ width (fill |> maximum 320)
        , height (fill |> maximum 480)
        , centerX
        , centerY
        , clip
        , Background.color colors.background
        ]
    <|
        [ -- header
          row
            [ width fill
            , height (px 40)
            ]
            []
        , el [ width fill, height fill ]
            (html <|
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
                            Html.div htmlAttrs [ Element.layout [] (card bird []) ]
                        )
                        (List.reverse model.remainingBirds)
                        ++ [ Html.div [ Html.Attributes.class "no-more" ] [ Html.text "We can't find any more birds near you! Try again later." ] ]
            )
        , --footer
          row
            [ centerX
            , centerY
            , height (px 40)
            , paddingEach
                { top = 0
                , bottom = 10
                , left = 20
                , right = 20
                }
            , spacing 20
            ]
            [ Input.button
                [ width (px 30)
                , height (px 30)
                , Background.color (rgb 1 1 1)
                , Border.rounded 100
                , Border.glow (rgb 0.8 0.8 0.8) 2
                ]
                { onPress = Just BirdDismissed
                , label = Icons.ex
                }
            , Input.button
                [ width (px 30)
                , height (px 30)
                , Background.color (rgb 1 1 1)
                , Border.rounded 100
                , Border.glow (rgb 0.8 0.8 0.8) 2
                ]
                { onPress = Just BirdLiked
                , label = Icons.heart
                }
            ]
        ]


card : BirdData -> List (Attribute Message) -> Element Message
card bird htmlAttrs =
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
