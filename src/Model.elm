module Model exposing (Flags, Model, init)

import Messages exposing (Message)


type alias Model =
    {}


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Message )
init flags =
    ( {}, Cmd.none )
