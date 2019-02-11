module Messages exposing (Message(..))

import Animation
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
    | CurrentTimeReceived Posix
