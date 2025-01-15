module Shared exposing (Data, Model, Msg, template)

import BackendTask exposing (BackendTask)
import BackendTask.Time
import Browser.Navigation
import Data.PlaceCal.Articles
import Data.PlaceCal.Events
import Data.PlaceCal.Partners
import Dict
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html
import Html.Styled
import Messages exposing (Msg(..))
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Theme.Global
import Theme.PageFooter exposing (viewPageFooter)
import Theme.PageHeader exposing (viewPageHeader)
import Time
import UrlPath exposing (UrlPath)
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



-------------
-- Data Types
-------------


type alias Data =
    { articles : List Data.PlaceCal.Articles.Article
    , partners : List Data.PlaceCal.Partners.Partner
    , time : Time.Posix
    }



----------------------------
-- Model, Messages & Update
----------------------------


type alias Msg =
    Messages.Msg


type alias Model =
    { showMobileMenu : Bool
    , filterParam : Maybe Int
    }


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMobileMenu = False
      , filterParam = filterFromPath maybePagePath
      }
    , Effect.none
    )


filterFromPath : Maybe { a | path : { q | query : Maybe String } } -> Maybe Int
filterFromPath maybePagePath =
    case maybePagePath of
        Just aPath ->
            case aPath.path.query of
                Just aQuery ->
                    Data.PlaceCal.Partners.filterFromQueryString (filterFromQueryParams aQuery)

                Nothing ->
                    Nothing

        Nothing ->
            Nothing


filterFromQueryParams : String -> String
filterFromQueryParams queryParams =
    Pages.PageUrl.parseQueryParams queryParams
        |> Dict.get "filter"
        |> Maybe.withDefault []
        |> List.head
        |> Maybe.withDefault ""


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }, Effect.none )

        -- Header
        ToggleMenu ->
            ( { model | showMobileMenu = not model.showMobileMenu }, Effect.none )

        -- Shared
        SharedMsg _ ->
            ( model, Effect.none )

        -- Update region filter
        SetRegion tagId ->
            ( { model | filterParam = Just tagId }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.map3 Data
        (BackendTask.map (\articlesData -> articlesData.allArticles) Data.PlaceCal.Articles.articlesData)
        (BackendTask.map (\partnersData -> partnersData.allPartners) Data.PlaceCal.Partners.partnersData)
        -- Consider using Pages.builtAt or Server.Request.requestTime
        BackendTask.Time.now
        |> BackendTask.allowFatal



-------
-- View
-------


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html.Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ Html.Styled.toUnstyled
            (Theme.Global.containerPage pageView.title
                [ View.fontPreload
                , Theme.Global.globalStyles
                , viewPageHeader page
                    { showMobileMenu = model.showMobileMenu }
                    |> Html.Styled.map toMsg
                , Html.Styled.main_ [] pageView.body
                , viewPageFooter sharedData.time
                ]
            )
        ]
    , title = pageView.title
    }
