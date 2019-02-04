module Messages exposing (Message(..))

import Animation


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
