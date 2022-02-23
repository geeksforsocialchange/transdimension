module Shared exposing (Data, Event, Model, Msg(..), Partner, SharedMsg(..), data, emptyEvent, emptyPartner, getRealm, template)

import Browser.Navigation
import DataSource
import Html
import Html.Attributes exposing (name)
import Html.Styled
import PageFooter exposing (viewPageFooter)
import PageHeader exposing (viewPageHeader)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Theme
import Time
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg



-------------
-- Data Types
-------------


type alias Data =
    { partners : List Partner
    , events : List Event
    }


type alias Partner =
    { id : String
    , name : String
    , summary : String
    , description : String
    }


emptyPartner : Partner
emptyPartner =
    { id = ""
    , name = ""
    , summary = ""
    , description = ""
    }


type alias Event =
    { id : String
    , name : String
    , summary : String
    , description : String
    , startDatetime : Time.Posix
    , endDatetime : Time.Posix
    , location : String
    , realm : Realm
    , partnerId : String
    }


emptyEvent : Event
emptyEvent =
    { id = ""
    , name = ""
    , summary = ""
    , description = ""
    , startDatetime = Time.millisToPosix 0
    , endDatetime = Time.millisToPosix 0
    , location = ""
    , realm = Offline
    , partnerId = ""
    }


type Realm
    = Online
    | Offline


getRealm : Event -> String
getRealm event =
    case event.realm of
        Online ->
            "Online"

        Offline ->
            "Offline"



----------------------------
-- Model, Messages & Update
----------------------------


type SharedMsg
    = NoOp


type alias Model =
    { showMobileMenu : Bool
    }


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    ( { showMobileMenu = False }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }, Cmd.none )

        SharedMsg globalMsg ->
            ( model, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : DataSource.DataSource Data
data =
    DataSource.succeed
        { partners =
            [ { id = "1"
              , name = "Partner one"
              , summary = "Partner one Info"
              , description = "Partner one intro"
              }
            , { id = "2"
              , name = "Partner two"
              , summary = "Partner two Info"
              , description = "Partner two intro"
              }
            , { id = "3"
              , name = "Partner three"
              , summary = "Partner three Info"
              , description = "Partner three intro"
              }
            , { id = "4"
              , name = "Partner four"
              , summary = "Partner four Info"
              , description = "Partner four intro"
              }
            ]
        , events =
            [ { id = "1"
              , name = "Event 1 name"
              , summary = "A summary of the first event"
              , description = "Fusce at sodales lacus. Morbi scelerisque lacus leo, ac mattis urna ultrices et. Proin ac eros faucibus, consequat ante vel, vulputate lectus. Nunc dictum pharetra ex, eget vestibulum lacus. Maecenas molestie felis in turpis eleifend, nec accumsan massa sodales. Nulla facilisi. Vivamus id rhoncus nulla. Nunc ultricies lectus et dui tempor sodales. Curabitur interdum lectus ultricies est ultricies, at faucibus nisi semper. Praesent iaculis ornare orci. Sed vel metus pharetra, efficitur leo a, porttitor magna. Curabitur sit amet mollis ex."
              , startDatetime = Time.millisToPosix 1645466400000
              , endDatetime = Time.millisToPosix 1650564000000
              , location = "Venue"
              , realm = Online
              , partnerId = "1"
              }
            , { id = "2"
              , name = "Event 2 name"
              , summary = "A summary of the second event"
              , description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ut risus placerat, suscipit lacus quis, pretium nisl. Fusce enim erat, fringilla ac auctor scelerisque, scelerisque non ipsum. Vivamus non elit id orci aliquam lobortis at sit amet ligula. Aenean vel massa pellentesque, viverra turpis et, commodo ipsum. Vivamus nunc elit, elementum et ipsum id, rutrum commodo sapien. Integer eget mi eget lacus sagittis molestie feugiat at lacus. Cras ultrices molestie blandit. Suspendisse gravida tortor non risus vestibulum laoreet. Nam nec quam id nisi suscipit consectetur. Aliquam venenatis tortor elit, id suscipit augue feugiat ac."
              , startDatetime = Time.millisToPosix 1645448400000
              , endDatetime = Time.millisToPosix 1658408400000
              , location = "Venue"
              , realm = Offline
              , partnerId = "2"
              }
            ]
        }



-------
-- View
-------


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html.Html msg, title : String }
view sharedData page model toMsg pageView =
    { body =
        Html.Styled.toUnstyled
            (Theme.containerPage pageView.title
                [ View.fontPreload
                , Theme.globalStyles
                , viewPageHeader
                , Html.Styled.main_ [] pageView.body
                , viewPageFooter
                ]
            )
    , title = pageView.title
    }
