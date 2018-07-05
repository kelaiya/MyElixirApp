--module MyApp exposing (..)
--import Html exposing (..)
--import Json.Decode exposing (..)
--import Html.Events exposing (..)
--import Http 

--import Html exposing (Html, button, div, text)
--import Html.Events exposing (onClick)


--main =
--  Html.beginnerProgram { model = model, view = view, update = update }


---- MODEL

--type alias Model =
--  { images : List Image
--  , myUserName : String
--  , systemError : String
--  }

--type alias Image =
--  { name: String
--  }

--init : ( Model, Cmd Msg )
--init =
--    { users = []
--    , myUserName = "Bill"
--    , systemError = ""
--    }
--        ! [ imagesRequest ]

--{--Decoders--}

--imageListDecoder : Json.Decode.Decoder (List Image)
--imageListDecoder =
--    Json.Decode.list imageDecoder

--imageDecoder : Json.Decode.Decoder Image
--imageDecoder =
--    Json.Decode.Pipeline.decode Image
--        |> Json.Decode.Pipeline.required "title" Json.Decode.string
--imagesRequest : Cmd Msg
--imagesRequest =
--    let
--        url =
--            "http://localhost:4000/api/images/"
--    in
--        Http.send ProcessImageRequest (Http.get url imageListDecoder)
---- UPDATE

--type Msg
--  = ProcessImageRequest (Result Http.Error String)


--update : Msg -> Model -> (Model, Cmd Msg)
--update msg model =
--  case msg of
--    ProcessImageRequest (Ok images) ->
--        { model | images = images } ! []
--    ProcessImageRequest (Err error) ->
--        { model | systemError = "error" } ! []


---- VIEW

--view : Model -> Html Msg
--view model =
--    div []
--        [ ul[]
--          [ List.map
--            (\n -> 
--              li [] [text n]
--            ) model.images
--          ]
--        ]

--main : Program Never Model Msg
--main =
--  Html.program
--    { init = init 
--    , view = view
--    , update = update
--    , subscriptions = Cmd.none
--    }


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as JD


{--Model--}


type alias Model =
   { name : List Image
   , error : String
   }


type alias Image =
   { name : String
   }

initModel : Model
initModel =
   { name = []
   , error = ""
   }


api : String
api =
   "/api/images"


getData : Http.Request (List Image)
getData =
   Http.get api getNames


getNames : JD.Decoder (List Image)
getNames =
   JD.list getName


getName : JD.Decoder Image
getName =
   JD.map Image
       (JD.field "name" JD.string)


type Msg
   = GotName
   | SetName (Result Http.Error (List Image))



{--Update--}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of
       GotName ->
           ( model, Cmd.none )

       SetName (Ok name) ->
           ( { model | name = name }, Cmd.none )

       SetName (Err error) ->
           ( { model | error = toString error }, Cmd.none )


initialCmd : Cmd Msg
initialCmd =
   Http.send SetName getData



{--View--}


view : Model -> Html Msg
view model =
   div []
       [ ul []
           (List.map
               (\n ->
                   li []
                       [ h2 [] [ text ("Title : " ++ n.name) ]
                       ]
               )
               model.name
           )
       ]


main : Program Never Model Msg
main =
   program
       { update = update
       , view = view
       , init = ( initModel, initialCmd )
       , subscriptions = always Sub.none
       }