module Model exposing (Flags, Model, Screen(..), init, initCardStyle, setDimensions)

import Animation
import Animation.Messenger
import BirdData exposing (..)
import Messages exposing (..)
import Task
import Time exposing (Posix)


type alias Model =
    { remainingBirds : List BirdData
    , likedBirds : List BirdData
    , dislikedBirds : List BirdData
    , topCardStyle : Animation.Messenger.State Message
    , screenStyle : Animation.Messenger.State Message
    , detailedView : Bool
    , currentScreen : Screen
    , cardAnimating : Bool
    , messageQueue : List BirdMessage
    , messages : List BirdMessageHistory
    , currentTime : Posix
    , lastMessageTime : Posix
    , timeZone : Time.Zone
    , windowDimensions : Dimensions
    }


type Screen
    = Match
    | Messages
    | MessageHistory String


type alias Flags =
    { birdData : List BirdData
    , windowDimensions : Dimensions
    }


type alias Dimensions =
    { width : Float, height : Float }


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { remainingBirds = flags.birdData
      , likedBirds = []
      , dislikedBirds = []
      , topCardStyle = initCardStyle
      , screenStyle = initScreenStyle
      , detailedView = False
      , currentScreen = Match
      , cardAnimating = False
      , messageQueue = []
      , messages = []
      , currentTime = Time.millisToPosix 0
      , lastMessageTime = Time.millisToPosix 0
      , timeZone = Time.utc
      , windowDimensions = flags.windowDimensions
      }
        |> setDimensions flags.windowDimensions
    , Time.here |> Task.perform TimeZoneReceived
    )


setDimensions : Dimensions -> Model -> Model
setDimensions windowDimensions model =
    let
        maxWidth =
            windowDimensions.height * 2 / 3

        newDimensions =
            { width = min maxWidth windowDimensions.width
            , height = windowDimensions.height
            }
    in
    { model | windowDimensions = newDimensions }


initCardStyle : Animation.Messenger.State Message
initCardStyle =
    Animation.style
        [ Animation.translate (Animation.px 0) (Animation.px 0)
        , Animation.rotate (Animation.deg 0)
        ]


initScreenStyle : Animation.Messenger.State Message
initScreenStyle =
    Animation.style
        [ Animation.translate (Animation.px 0) (Animation.px 0)
        ]
