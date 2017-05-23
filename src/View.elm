module View exposing (view)

import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseDown, onInput, onClick)
import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))
import Helpers exposing (..)
import Types exposing (Draggable(..))


view : Model -> Html Msg
view model =
    let
        views =
            case model.currentUser of
                Just username ->
                    [ viewNav username
                    , viewProfile model
                    ]

                Nothing ->
                    [ viewLogin model ]
    in
        div [] views


viewProfile : Model -> Html Msg
viewProfile model =
    div []
        [ h2 [ class "subtitle" ] [ text "This is your profile:" ]
        , viewName model
        , viewPic model
        ]


viewLogin : Model -> Html Msg
viewLogin model =
    let
        ( authErr, errClass ) =
            case model.authErr of
                Just error ->
                    ( error, "notification is-danger" )

                Nothing ->
                    ( "", "" )
    in
        div [ class "container" ]
            [ div [ class "login-form box" ]
                [ div [ class "field" ]
                    [ p [ class "control has-icons-left" ]
                        [ input [ class "input", placeholder "Username", onInput ChangeUsername ]
                            []
                        , span [ class "icon is-small is-left" ]
                            [ i [ class "fa fa-user" ]
                                []
                            ]
                        ]
                    ]
                , div [ class "field" ]
                    [ p [ class "control has-icons-left" ]
                        [ input [ class "input", placeholder "Password", type_ "password", onInput ChangePassword ]
                            []
                        , span [ class "icon is-small is-left" ]
                            [ i [ class "fa fa-lock" ]
                                []
                            ]
                        ]
                    ]
                , div [ class "field" ]
                    [ p [ class "control" ]
                        [ button [ class "button is-info", onClick SubmitLogin ]
                            [ text "Let me in" ]
                        ]
                    ]
                , div [ class errClass ] [ text authErr ]
                ]
            ]


viewNav : String -> Html Msg
viewNav username =
    nav [ class "nav" ]
        [ div [ class "nav-left" ]
            [ a [ class "nav-item" ]
                [ text <| "Welcome, " ++ username ++ "!"
                ]
            ]
        , div [ class "nav-right nav-menu" ]
            [ div [ class "nav-item" ]
                [ p [ class "control" ]
                    [ a [ class "button is-outlined", onClick Logout ]
                        [ span [ class "icon" ]
                            [ i [ class "fa fa-sign-out" ] []
                            ]
                        , span [] [ text "Sign out!" ]
                        ]
                    ]
                ]
            ]
        ]


viewName : Model -> Html Msg
viewName model =
    let
        realPosition =
            model.namePosition
    in
        div
            [ style
                [ ( "left", px realPosition.x )
                , ( "top", px realPosition.y )
                ]
            , class "dragabble"
            ]
            [ strong [] [ text "Name: " ]
            , div
                [ onMouseDown <| DragStart Name
                , class "name"
                ]
                [ text (Maybe.withDefault "" model.currentUser)
                ]
            ]


viewPic : Model -> Html Msg
viewPic model =
    let
        realPosition =
            model.picPosition
    in
        div
            [ style
                [ ( "left", px realPosition.x )
                , ( "top", px realPosition.y )
                ]
            , class "dragabble"
            ]
            [ strong [] [ text "Pic: " ]
            , div []
                [ img
                    [ onMouseDown <| DragStart Pic
                    , src "images/pic_100x100.jpg"
                    , alt "None"
                    ]
                    []
                ]
            ]
