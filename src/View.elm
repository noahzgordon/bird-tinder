module View exposing (view)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Icons
import Messages exposing (Message)
import Model exposing (Model)


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
        , Background.color colors.background
        ]
        [ -- header
          row
            [ width fill
            , height (px 40)
            ]
            []
        , --picture
          el
            [ width fill
            , height fill
            , padding 10
            , behindContent
                (el
                    [ height fill
                    , width fill
                    , spacing 10
                    , Background.image "https://images.pexels.com/photos/792416/pexels-photo-792416.jpeg?cs=srgb&dl=animal-avian-beak-792416.jpg&fm=jpg"
                    , Border.width 10
                    , Border.color colors.background
                    , Border.rounded 20
                    , Border.solid
                    ]
                    none
                )
            ]
          <|
            column
                [ alignBottom
                , Font.color (rgb 1 1 1)
                , Font.glow (rgb 0 0 0) 1
                , padding 10
                , spacing 5
                ]
                [ el [ Font.size 28 ] (text "a tiny birb")
                , el [ Font.size 18 ] (text "a tree near you")
                , el [ Font.size 18 ] (text "30 feet away")
                ]
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
                { onPress = Nothing
                , label = Icons.ex
                }
            , Input.button
                [ width (px 30)
                , height (px 30)
                , Background.color (rgb 1 1 1)
                , Border.rounded 100
                , Border.glow (rgb 0.8 0.8 0.8) 2
                ]
                { onPress = Nothing
                , label = Icons.heart
                }
            ]
        ]
