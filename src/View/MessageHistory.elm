module View.MessageHistory exposing (view)

import Model.Types.BirdData exposing (..)
import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Icons
import List.Extra as List
import Messages exposing (..)
import Model exposing (..)
import Model.Types exposing (..)
import View.MessageScreen.Header as Header
import View.MessageScreen.Messages as Messages


view : Model -> Element Message
view model =
    el
        [ width (px <| round model.windowDimensions.width)
        , height (px <| round model.windowDimensions.height)
        , scrollbarY
        , clipX
        ]
        (el
            [ width fill, height fill ]
            (case model.currentScreen of
                MessageHistory chosenBirdName ->
                    case
                        ( List.find (\{ name } -> name == chosenBirdName) model.likedBirds
                        , List.find (\{ birdName } -> birdName == chosenBirdName) model.messages
                        )
                    of
                        ( Just birdData, Just history ) ->
                            drawHistory birdData history

                        _ ->
                            none

                _ ->
                    none
            )
        )


drawHistory : BirdData -> BirdMessageHistory -> Element Message
drawHistory data history =
    column [ width fill, height fill ]
        [ column [ width fill, height (px 60) ]
            [ row [ width fill, height (px 40) ]
                [ el
                    [ width (px 70)
                    , height (px 30)
                    , centerY
                    , alignLeft
                    ]
                    (Input.button [ width (px 30), height fill, centerX, moveDown 5 ]
                        { onPress = Just MessageScreenButtonClicked
                        , label = Icons.message
                        }
                    )
                , el
                    [ width (px 40)
                    , height (px 40)
                    , centerY
                    , centerX
                    , moveLeft 35
                    , moveDown 10
                    , Background.image data.image
                    , Border.rounded 20
                    , Border.solid
                    ]
                    none
                ]
            , el
                [ width fill
                , height (px 20)
                , centerX
                , moveDown 15
                , Font.center
                , Font.size 12
                , Font.color Colors.gray
                ]
                (text data.name)
            ]
        , column [ width fill, height fill, paddingXY 20 40, spacing 10 ]
            (List.map drawMessage (List.reverse history.messages))
        ]


drawMessage : SentBirdMessage -> Element Message
drawMessage message =
    el
        [ Border.solid
        , Border.rounded 15
        , Background.color Colors.lightGray
        , padding 10
        ]
        (text message.text)
