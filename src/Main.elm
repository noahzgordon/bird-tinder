module Main exposing (main)

import Browser
import Messages exposing (Message)
import Model exposing (init)
import Model.Types exposing (..)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main : Platform.Program Flags Model Message
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
