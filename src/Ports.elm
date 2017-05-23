port module Ports exposing (..)

import Types exposing (Session)


-- Outbound ports


port setSession : Session -> Cmd msg


port removeSession : () -> Cmd msg
