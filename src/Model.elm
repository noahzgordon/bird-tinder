module Model exposing (BirdData, Flags, Model, Screen(..), init, initCardStyle)

import Animation
import Animation.Messenger
import Messages exposing (Message)


type alias Model =
    { remainingBirds : List BirdData
    , likedBirds : List BirdData
    , dislikedBirds : List BirdData
    , topCardStyle : Animation.Messenger.State Message
    , showNextCard : Bool
    , detailedView : Bool
    , currentScreen : Screen
    }


type Screen
    = Match
    | Messages


type alias BirdData =
    { name : String
    , location : String
    , description : String
    , distance : String
    , image : String
    , message : Maybe String
    }


type alias Flags =
    { birdData : List BirdData
    }


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { remainingBirds = flags.birdData
      , likedBirds = []
      , dislikedBirds = []
      , topCardStyle = initCardStyle
      , showNextCard = False
      , detailedView = False
      , currentScreen = Match
      }
    , Cmd.none
    )


initCardStyle : Animation.Messenger.State Message
initCardStyle =
    Animation.style
        [ Animation.translate (Animation.px 0) (Animation.px 0)
        , Animation.rotate (Animation.deg 0)
        ]
