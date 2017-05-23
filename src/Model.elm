module Model exposing (..)

import Types exposing (Session, Draggable)
import Mouse exposing (Position)


type alias Model =
    { username : String
    , password : String
    , authErr : Maybe String
    , currentUser : Maybe String
    , namePosition : Position
    , picPosition : Position
    , dragged : Maybe Draggable
    }


initialModel : Maybe Session -> Model
initialModel session =
    let
        ( currentUser, namePosition, picPosition ) =
            case session of
                Just { currentUser, namePosition, picPosition } ->
                    ( Just currentUser, namePosition, picPosition )

                Nothing ->
                    ( Nothing, defaultNamePosition, defaultPicPosition )
    in
        { username = ""
        , password = ""
        , authErr = Nothing
        , currentUser = currentUser
        , namePosition = namePosition
        , picPosition = picPosition
        , dragged = Nothing
        }


defaultPicPosition : Position
defaultPicPosition =
    { x = 10, y = 100 }


defaultNamePosition : Position
defaultNamePosition =
    { x = 10, y = 300 }
