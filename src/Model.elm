module Model exposing (Flags, Model, init)

import Messages exposing (Message)


type alias Model =
    { birds : List BirdData
    }


type alias BirdData =
    { name : String
    , location : String
    }


type alias Flags =
    { birdData : List BirdData
    }


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { birds = flags.birdData }
    , Cmd.none
    )
