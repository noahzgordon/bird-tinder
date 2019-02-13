module Messages exposing (AnimationMessage(..), Message(..))

import Animation
import Model.Types.BirdData exposing (BirdMessageHistory)
import Time exposing (Posix)


type AnimationMessage
    = TopCard Animation.Msg
    | Screen Animation.Msg
    | IntroTitle Animation.Msg


type Message
    = Animate AnimationMessage
    | IntroAnimationCompleted
    | BirdDismissed
    | BirdLiked
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
    | ScreenClicked
