module Msg exposing (Msg(..))

import Types exposing (Draggable)
import Mouse exposing (Position)


type Msg
    = ChangeUsername String
    | ChangePassword String
    | SubmitLogin
    | GotAuthenticateResponse (Result String String)
    | Logout
    | DragStart Draggable
    | DragAt Position
    | DragEnd Position
