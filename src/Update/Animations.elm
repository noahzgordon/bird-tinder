module Update.Animations exposing (update)

import Animation.Messenger
import Messages exposing (..)
import Model.Types exposing (Model)


update : AnimationMessage -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        TopCard animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.topCardStyle
            in
            ( { model | topCardStyle = newStyle }, cmds )

        Screen animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.screenStyle
            in
            ( { model | screenStyle = newStyle }, cmds )

        IntroTitle animateMsg ->
            let
                ( newStyle, cmds ) =
                    Animation.Messenger.update animateMsg model.introTitleStyle
            in
            ( { model | introTitleStyle = newStyle }, cmds )
