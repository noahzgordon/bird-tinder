module Update exposing (update)

import Messages exposing (Message)
import Model exposing (Model)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    ( model, Cmd.none )
