module View.MessageScreen.Messages exposing (view)

import Model.Types.BirdData exposing (..)
import Colors
import DateFormat
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import List.Extra as List
import Messages exposing (..)
import Model.Types exposing (Model)
import Time exposing (Posix, Zone, toHour, toMinute)


view : Model -> Element Message
view model =
    column
        [ paddingXY 10 30, width fill ]
        [ el [ paddingXY 10 0, Font.color Colors.red, Font.bold ]
            (text "Messages")
        , drawMessages model
        ]


drawMessages : Model -> Element Message
drawMessages model =
    case model.messages of
        [] ->
            paragraph [ paddingXY 10 20 ] [ text "You don't have any messages yet!" ]

        messages ->
            column [ paddingXY 0 20, width fill ]
                (List.map (drawMessage model) messages)


drawMessage : Model -> BirdMessageHistory -> Element Message
drawMessage model history =
    case
        ( List.head history.messages
        , List.find (\{ name } -> name == history.birdName) model.likedBirds
        )
    of
        ( Just m, Just data ) ->
            row
                [ onClick (MessageHistoryClicked history)
                , pointer
                , mouseOver [ Background.color Colors.backgroundLowlight ]
                , width fill
                , height (px 80)
                , paddingXY 10 10
                , spacing 10
                , Border.solid
                , Border.rounded 10
                ]
                [ el
                    [ width (px 60)
                    , height (px 60)
                    , Background.image data.image
                    , Border.rounded 50
                    , Border.solid
                    , alignLeft
                    ]
                    none
                , column [ width fill, height fill, spacing 10 ]
                    [ row [ spacing 5 ]
                        [ el [ Font.bold ] (text history.birdName)
                        , el [ Font.italic, Font.size 12 ] (text <| formatDate model.timeZone m.timestamp)
                        ]
                    , paragraph [ width fill, Font.color Colors.gray ]
                        [ text m.text ]
                    ]
                ]

        _ ->
            none


formatDate : Zone -> Posix -> String
formatDate =
    DateFormat.format
        [ DateFormat.hourNumber
        , DateFormat.text ":"
        , DateFormat.minuteFixed
        , DateFormat.text " "
        , DateFormat.amPmUppercase
        ]
