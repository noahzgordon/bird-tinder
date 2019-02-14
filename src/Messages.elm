module Messages exposing (AnimationMessage(..), Message(..))

import Animation
import Model.Types.BirdData exposing (..)
import Time exposing (Posix)


type AnimationMessage
    = TopCard Animation.Msg
    | Screen Animation.Msg
    | IntroTitle Animation.Msg
    | MatchAnim Animation.Msg


type Message
    = Animate AnimationMessage
    | IntroAnimationCompleted
    | BirdDismissed
    | BirdLiked BirdData
    | BirdLikeCompleted
    | BirdDismissalCompleted
    | DetailOpenClicked
    | DetailCloseClicked
    | MessageScreenButtonClicked
    | MatchScreenButtonClicked
    | MessageHistoryClicked BirdMessageHistory
    | CurrentTimeReceived Posix
    | TimeZoneReceived Time.Zone
    | WindowSizeInformationReceived Int Int
    | BirdsRandomized (List BirdData)
