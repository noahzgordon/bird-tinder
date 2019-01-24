module Icons exposing (ex, heart)

import Element exposing (Element)
import Svg exposing (g, path, svg)
import Svg.Attributes exposing (d, fill, transform, viewBox)


ex : Element msg
ex =
    Element.html <|
        svg [ viewBox "0 0 60 60" ]
            [ path
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
                [ path
                    [ d "M50.8 34.2c0-5.56-3.7-9.6-8.84-9.6-2.75 0-4.23 1-6.6 3.3-2.38-2.3-3.86-3.32-6.6-3.32-5.14 0-8.86 4.05-8.86 9.63 0 2.35.83 4.56 2.37 6.3l12.4 11.37c.38.34 1 .34 1.37 0l11.2-10.17.68-.62.25-.28.26-.27c1.54-1.75 2.38-3.97 2.38-6.32"
                    ]
                    []
                ]
            ]
