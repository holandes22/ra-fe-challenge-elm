module Types exposing (..)

import Mouse exposing (Position)


type alias Session =
    { currentUser : String
    , namePosition : Position
    , picPosition : Position
    }


type Draggable
    = Name
    | Pic
