module Main exposing (..)

import Html exposing (Html)
import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))
import Update exposing (update)
import Mouse
import View exposing (view)
import Types exposing (Session)


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.dragged of
        Nothing ->
            Sub.none

        Just _ ->
            Sub.batch
                [ Mouse.moves DragAt
                , Mouse.ups DragEnd
                ]


type alias Flags =
    { session : Maybe Session
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel flags.session, Cmd.none )
