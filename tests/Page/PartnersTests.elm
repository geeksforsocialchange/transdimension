module Page.PartnersTests exposing (..)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Data.TestFixtures as Fixtures
import Expect
import Html
import Page.Partners exposing (view)
import Pages.Url
import Path
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import TestUtils exposing (queryFromStyledList)


viewParamsWithPartners =
    { data = Fixtures.partners
    , path = Path.fromString "partners"
    , routeParams = {}
    , sharedData =
        { news = Fixtures.news
        }
    }


viewParamsWithoutPartners =
    { data = []
    , path = Path.fromString "partners"
    , routeParams = {}
    , sharedData =
        { news = Fixtures.news
        }
    }


viewBodyHtml viewParams =
    queryFromStyledList
        (view Nothing { showMobileMenu = False } viewParams).body


suite : Test
suite =
    describe "Partners page body"
        [ test "Has expected h2 heading" <|
            \_ ->
                viewBodyHtml viewParamsWithPartners
                    |> Query.find [ Selector.tag "h2" ]
                    |> Query.contains [ Html.text (t PartnersTitle) ]
        , test "Has intro text" <|
            \_ ->
                viewBodyHtml viewParamsWithPartners
                    |> Query.contains [ Html.text (t PartnersIntroSummary) ]
        , test "Contains a list of all partners" <|
            \_ ->
                viewBodyHtml viewParamsWithPartners
                    |> Query.find [ Selector.tag "ul" ]
                    |> Query.children [ Selector.tag "li" ]
                    |> Query.count (Expect.equal 4)
        , test "Does not contain list if there are no partners" <|
            \_ ->
                viewBodyHtml viewParamsWithoutPartners
                    |> Query.hasNot [ Selector.tag "ul" ]
        , test "Contains filter controls" <|
            \_ ->
                viewBodyHtml viewParamsWithPartners
                    -- Note this is currently a placeholder
                    |> Query.contains [ Html.text "[fFf] Filters" ]
        , test "Contains map" <|
            \_ ->
                viewBodyHtml viewParamsWithPartners
                    -- Note this is currently a placeholder
                    |> Query.contains [ Html.text "[fFf] Map" ]
        ]
