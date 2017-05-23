module Update exposing (update)

import Msg exposing (Msg(..))
import Model exposing (Model, defaultPicPosition, defaultNamePosition)
import Ports as Ports
import Types exposing (Draggable(..), Session)
import Mouse exposing (Position)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePassword password ->
            ( { model | password = password }
            , Cmd.none
            )

        ChangeUsername username ->
            ( { model | username = username }
            , Cmd.none
            )

        GotAuthenticateResponse result ->
            case result of
                Ok username ->
                    ( { model | authErr = Nothing, currentUser = Just username }
                    , Ports.setSession (getSession username model)
                    )

                Err error ->
                    ( { model | authErr = Just error, currentUser = Nothing }
                    , Cmd.none
                    )

        SubmitLogin ->
            authenticate model

        Logout ->
            ( { model
                | authErr = Nothing
                , currentUser = Nothing
                , picPosition = defaultPicPosition
                , namePosition = defaultNamePosition
              }
            , Ports.removeSession ()
            )

        DragStart draggable ->
            ( { model | dragged = Just draggable }
            , Cmd.none
            )

        DragAt xy ->
            ( dragAtHelper xy model
            , Cmd.none
            )

        DragEnd _ ->
            ( { model | dragged = Nothing }
            , Ports.setSession (getSession model.username model)
            )


getSession : String -> Model -> Session
getSession username { namePosition, picPosition } =
    { currentUser = username, namePosition = namePosition, picPosition = picPosition }


dragAtHelper : Position -> Model -> Model
dragAtHelper xy model =
    case model.dragged of
        Nothing ->
            model

        Just draggable ->
            case draggable of
                Name ->
                    { model | namePosition = xy }

                Pic ->
                    { model | picPosition = xy }


authenticate : Model -> ( Model, Cmd Msg )
authenticate model =
    -- mimic an HTTP API call
    if model.password == "123" then
        update (GotAuthenticateResponse (Ok model.username)) model
    else
        update (GotAuthenticateResponse (Err "Authentication error (hint: password is 123)")) model
