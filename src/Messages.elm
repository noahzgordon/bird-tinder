module Messages exposing (Message(..))

import Animation
import BirdData exposing (BirdMessageHistory)
import Time exposing (Posix)


type Message
    = AnimateTopCard Animation.Msg
    | AnimateScreen Animation.Msg
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
