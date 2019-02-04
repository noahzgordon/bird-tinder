module View.MatchScreen.Footer exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Icons
import Messages exposing (..)
import Model exposing (Model)


view : Model -> Element Message
view model =
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
        , inFront <|
            if not (List.isEmpty model.remainingBirds) then
                row
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

            else
                none
        ]
        [ if model.detailedView then
            case List.head model.remainingBirds of
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
