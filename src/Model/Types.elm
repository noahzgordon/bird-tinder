module Model.Types exposing (Dimensions, Flags, Model, Screen(..))

import Animation.Messenger
import Messages exposing (..)
import Model.Types.BirdData exposing (..)
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
