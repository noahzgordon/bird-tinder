module Icons exposing (ex, heart, info, message, pecker, profile, retract)

import Element exposing (Element, el)
import Element.Font as Font
import Svg exposing (..)
import Svg.Attributes exposing (..)


ex : Element msg
ex =
    Element.html <|
        svg [ viewBox "0 0 60 60" ]
            [ Svg.path
                [ d "M151.6 43.7v-1.4l6.5 6.5c1.3 1.2 1.3 3 0 4.3-1 1.3-3 1.3-4.2 0l-6.5-6.4h1.4l-6.5 6.5c-1.2 1.3-3 1.3-4.3 0-1.3-1-1.3-3 0-4.2l6.4-6.5v1.4l-6.5-6.5c-1.3-1.2-1.3-3 0-4.3 1-1.3 3-1.3 4.2 0l6.5 6.4h-1.4l6.5-6.5c1.2-1.3 3-1.3 4.3 0 1.3 1 1.3 3 0 4.2l-6.4 6.5z"
                , fill "red"
                , transform "translate(-118 -13)"
                ]
                []
            ]


heart : Element msg
heart =
    Element.html <|
        svg [ viewBox "0 0 55 55" ]
            [ g
                [ transform "translate(-8.13, -9)"
                , fill "green"
                ]
                [ Svg.path
                    [ d "M50.8 34.2c0-5.56-3.7-9.6-8.84-9.6-2.75 0-4.23 1-6.6 3.3-2.38-2.3-3.86-3.32-6.6-3.32-5.14 0-8.86 4.05-8.86 9.63 0 2.35.83 4.56 2.37 6.3l12.4 11.37c.38.34 1 .34 1.37 0l11.2-10.17.68-.62.25-.28.26-.27c1.54-1.75 2.38-3.97 2.38-6.32"
                    ]
                    []
                ]
            ]


info : Element msg
info =
    Element.html <|
        svg [ width "30", height "31" ]
            [ g
                [ transform "translate(2 1.531)"
                , fill "none"
                , fillRule "evenodd"
                ]
                [ Svg.path
                    [ d "M11.6 10.719h2.8v8.4h-2.8v-8.4zm1.4-1.4a1.75 1.75 0 1 1 0-3.5 1.75 1.75 0 0 1 0 3.5z"
                    , fill "#424242"
                    ]
                    []
                ]
            ]


retract : Element msg
retract =
    Element.html <|
        svg [ width "48px", height "48px", viewBox "0 0 48 48" ]
            [ g [ stroke "none", strokeWidth "1", fill "none", fillRule "evenodd" ]
                [ Svg.path
                    [ d "m13.065 25.574l2.617 2.1455c1.0475 0.85897 2.762 2.2647 3.8095 3.1232l2.617 2.1459c1.0475 0.85897 1.9045 0.45324 1.9045-0.90153v-4.1583c1.5853-0.23107 7.6268-0.96783 8.9569-1.1613 1.5839-0.23107 2.7516-1.2385 2.7516-2.7516v-0.0064324c0-1.5136-1.1677-2.521-2.7516-2.7521-1.33-0.19347-7.3715-0.93022-8.9569-1.1613v-4.1583c0-1.3548-0.85699-1.76-1.9045-0.90153l-2.617 2.1459c-1.0475 0.85897-2.762 2.2642-3.8095 3.1232l-2.617 2.1455c-1.0475 0.85897-1.0475 2.2642 0 3.1232"
                    , fill "#424242"
                    , transform "translate(24 24.012) scale(-1 1) rotate(-90) translate(-24 -24.012)"
                    ]
                    []
                ]
            ]


message : Element msg
message =
    Element.html <|
        svg [ width "34px", height "34px", viewBox "0 0 34 29" ]
            [ g [ stroke "none", strokeWidth "1" ]
                [ Svg.path
                    [ d "M16.3 20.2c0-4.6 4.4-8.5 10-8.5 1.3 0 2.6.3 3.8.7 0-6.6-6.7-12-14.8-12C7 .4.2 6 .2 12.7.2 17 3 21 7.2 23v4.5c0 .5.4.8 1 .5l6-3h1.5c.7 0 1.4 0 2-.2-1-1.4-1.4-3-1.4-4.6zm10-6c-4.2 0-7.6 2.6-7.6 6s3.4 6.2 7.5 6.2h.5l1 .4 1.6 1c.5 0 1 0 1-.6v-1.8c2-1 3.4-3 3.4-5.2 0-3.4-3.3-6-7.5-6z"
                    , fill "#888"
                    ]
                    []
                ]
            ]


profile : Element msg
profile =
    Element.html <|
        svg [ width "22px", height "27px", viewBox "0 0 22 27" ]
            [ g [ stroke "none", strokeWidth "1" ]
                [ Svg.path
                    [ d "M15 14.7c1.6-1.3 2.6-3.5 2.6-7.4 0-4-3.3-7.3-7.3-7.3S3 3.2 3 7.3c0 4 1 6.3 2.7 7.6C2.3 17-1 21 .2 23 2.7 27.7 19 28 21 23.2c.8-2.3-2.5-6.2-6-8.5"
                    , fill "#888"
                    ]
                    []
                ]
            ]


pecker : Element msg
pecker =
    el
        [ Font.size 36
        , Font.family
            [ Font.typeface "Comic Sans MS"
            , Font.typeface "cursive"
            , Font.sansSerif
            ]
        ]
    <|
        Element.text "P"
