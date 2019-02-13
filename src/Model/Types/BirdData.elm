module Model.Types.BirdData exposing (BirdData, BirdMessage, BirdMessageHistory, SentBirdMessage)

import Time exposing (Posix)


type alias BirdData =
    { name : String
    , location : String
    , description : String
    , distance : String
    , image : String
    , message : String
    }


type alias BirdMessage =
    { birdName : String
    , message : String
    }


type alias BirdMessageHistory =
    { birdName : String
    , messages : List SentBirdMessage
    }


type alias SentBirdMessage =
    { text : String, unread : Bool, timestamp : Posix }
