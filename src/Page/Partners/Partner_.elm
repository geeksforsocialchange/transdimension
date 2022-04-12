module Page.Partners.Partner_ exposing (Data, Model, Msg, page, view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, auto, backgroundColor, batch, block, bold, center, color, display, fontSize, fontWeight, hover, margin2, marginBottom, none, padding, pct, rem, textAlign, textDecoration, width)
import Data.PlaceCal.Events
import Data.PlaceCal.Partners
import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Helpers.TransRoutes as TransRoutes exposing (Route(..))
import Html.Styled exposing (Html, a, address, div, h2, h3, p, section, text)
import Html.Styled.Attributes exposing (css, href)
import Page exposing (Page, PageWithState, StaticPayload)
import Page.Events
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import Theme.Global
import Theme.PageTemplate as PageTemplate exposing (HeaderType(..))
import Theme.TransMarkdown
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { partner : String }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    DataSource.map
        (\partnerData ->
            partnerData.allPartners
                |> List.map (\partner -> { partner = partner.id })
        )
        Data.PlaceCal.Partners.partnersData


data : RouteParams -> DataSource Data
data routeParams =
    DataSource.map2
        (\partnerData eventData ->
            -- There probably a better pattern than succeed with empty.
            -- In theory all will succeed since routes mapped from same list.
            { partner =
                Maybe.withDefault Data.PlaceCal.Partners.emptyPartner
                    ((partnerData.allPartners
                        -- Filter for partner with matching id
                        |> List.filter (\partner -> partner.id == routeParams.partner)
                     )
                        -- There should only be one, so take the head
                        |> List.head
                    )
            , events = Data.PlaceCal.Events.eventsFromPartnerId eventData routeParams.partner
            }
        )
        Data.PlaceCal.Partners.partnersData
        (DataSource.map (\eventsData -> eventsData.allEvents) Data.PlaceCal.Events.eventsData)


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = t (PartnerMetaDescription static.data.partner.name)
        , locale = Nothing
        , title = t (PartnerTitle static.data.partner.name)
        }
        |> Seo.website


type alias Data =
    { partner : Data.PlaceCal.Partners.Partner
    , events : List Data.PlaceCal.Events.Event
    }


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = static.data.partner.name
    , body =
        [ PageTemplate.view
            { variant = PinkHeader
            , intro =
                { title = t PartnersTitle
                , bigText = static.data.partner.name
                , smallText = []
                }
            }
            (Just
                (div []
                    [ viewInfo static.data
                    , a [ href (TransRoutes.toAbsoluteUrl Partners), css [ goBackStyle ] ] [ text (t BackToPartnersLinkText) ]
                    ]
                )
            )
            Nothing
        ]
    }


viewInfo : Data -> Html msg
viewInfo { partner, events } =
    section []
        [ p [] (Theme.TransMarkdown.markdownToHtml partner.description)
        , div []
            [ div []
                [ h3 [ css [ contactHeadingStyle ] ] [ text (t PartnerContactsHeading) ]
                , viewContactDetails partner.maybeUrl partner.contactDetails
                ]
            , div []
                [ h3 [ css [ contactHeadingStyle ] ] [ text (t PartnerAddressHeading) ]
                , viewAddress partner.maybeAddress
                ]
            ]
        , div [ css [ featurePlaceholderStyle ] ] [ text "[fFf] Map" ]
        , if List.length events > 0 then
            Page.Events.viewEventsList events

          else
            text (t (PartnerEventsEmptyText partner.name))
        ]


viewContactDetails : Maybe String -> Data.PlaceCal.Partners.Contact -> Html msg
viewContactDetails maybeUrl contactDetails =
    address []
        [ if String.length contactDetails.telephone > 0 then
            p [] [ text contactDetails.telephone ]

          else
            text ""
        , if String.length contactDetails.telephone > 0 then
            p [] [ text contactDetails.email ]

          else
            text ""
        , case maybeUrl of
            Just url ->
                p [] [ text url ]

            Nothing ->
                text ""
        ]


viewAddress : Maybe Data.PlaceCal.Partners.Address -> Html msg
viewAddress maybeAddress =
    case maybeAddress of
        Just addressFields ->
            address []
                [ p [] [ text addressFields.streetAddress ]
                , p []
                    [ text addressFields.addressRegion
                    , text ", "
                    , text addressFields.postalCode
                    ]
                ]

        Nothing ->
            text (t PartnerAddressEmptyText)



---------
-- Styles
---------


featurePlaceholderStyle : Style
featurePlaceholderStyle =
    batch
        [ fontWeight bold
        , marginBottom (rem 2)
        ]


partnerHeadingStyle : Style
partnerHeadingStyle =
    batch
        [ textAlign center
        , fontSize (rem 2)
        ]


contactHeadingStyle : Style
contactHeadingStyle =
    -- Temp style so I can see it
    batch [ color Theme.Global.pink ]


goBackStyle : Style
goBackStyle =
    batch
        [ backgroundColor Theme.Global.darkBlue
        , color Theme.Global.white
        , textDecoration none
        , padding (rem 1)
        , display block
        , width (pct 25)
        , margin2 (rem 2) auto
        , textAlign center
        , hover [ backgroundColor Theme.Global.blue, color Theme.Global.black ]
        ]
