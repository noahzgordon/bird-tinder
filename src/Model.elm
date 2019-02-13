module Model exposing (init, setDimensions)

import Animation
import Animation.Messenger
import Messages exposing (..)
import Model.Animations exposing (initCardStyle, initIntroTitleStyle, initScreenStyle)
import Model.Types exposing (..)
import Model.Types.BirdData exposing (..)
import Task
import Time exposing (Posix)


init : Flags -> ( Model, Cmd Message )
init flags =
    ( { remainingBirds = flags.birdData
      , likedBirds = []
      , dislikedBirds = []
      , topCardStyle = initCardStyle
      , screenStyle = initScreenStyle
      , introTitleStyle = initIntroTitleStyle
      , detailedView = False
      , currentScreen = Intro
      , cardAnimating = False
      , messageQueue = []
      , messages = []
      , currentTime = Time.millisToPosix 0
      , lastMessageTime = Time.millisToPosix 0
      , timeZone = Time.utc
      , windowDimensions = flags.windowDimensions
      , matchNotification = Nothing
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
