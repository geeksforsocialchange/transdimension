module Page.Partners.Partner_ exposing (Data, Model, Msg, page, view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, auto, backgroundColor, batch, block, bold, borderColor, borderRadius, borderStyle, borderWidth, center, color, display, displayFlex, fontSize, fontStyle, fontWeight, hover, int, margin2, margin4, marginBottom, marginTop, maxWidth, none, normal, padding, padding2, pct, property, px, rem, solid, textAlign, textDecoration, width)
import Data.PlaceCal.Events
import Data.PlaceCal.Partners
import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Helpers.TransRoutes as TransRoutes exposing (Route(..))
import Html.Styled exposing (Html, a, address, div, h2, h3, hr, p, section, text)
import Html.Styled.Attributes exposing (css, href, target)
import Page exposing (Page, PageWithState, StaticPayload)
import Page.Events
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import Theme.Global exposing (hrStyle, linkStyle, normalFirstParagraphStyle, pink, smallInlineTitleStyle, viewBackButton, white, withMediaTabletLandscapeUp, withMediaTabletPortraitUp)
import Theme.PageTemplate as PageTemplate exposing (BigTextType(..), HeaderType(..))
import Theme.TransMarkdown
import View exposing (View)
import Css exposing (marginBlockStart)
import Css exposing (marginBlockEnd)


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
                , bigText = { text = static.data.partner.name, element = H3 }
                , smallText = []
                }
            }
            (Just
                (viewInfo static.data)
            )
            (Just (viewBackButton (TransRoutes.toAbsoluteUrl Partners) (t BackToPartnersLinkText)))
        ]
    }


viewInfo : Data -> Html msg
viewInfo { partner, events } =
    section [ css [ margin2 (rem 0) (rem 0.35) ] ]
        [ div [] [ text "Space for logo or image" ]
        , hr [ css [ hrStyle ] ] []
        , div [ css [ descriptionStyle ] ] (Theme.TransMarkdown.markdownToHtml partner.description)
        , hr [ css [ hrStyle ] ] []
        , section [ css [ contactWrapperStyle ] ]
            [ div [ css [ contactSectionStyle ] ]
                [ h3 [ css [ contactHeadingStyle, Theme.Global.smallInlineTitleStyle ] ] [ text (t PartnerContactsHeading) ]
                , viewContactDetails partner.maybeUrl partner.contactDetails
                ]
            , div [ css [ contactSectionStyle ] ]
                [ h3 [ css [ contactHeadingStyle, Theme.Global.smallInlineTitleStyle ] ] [ text (t PartnerAddressHeading) ]
                , viewAddress partner.maybeAddress
                ]
            ]
        , hr [ css [ hrStyle ] ] []
        , section []
            [ h3 [ css [ smallInlineTitleStyle, color white ] ] [ text (t PartnerUpcomingEventsText) ]
            ]
        , if List.length events > 0 then
            Page.Events.viewEventsList events

          else
            p [ css [ contactItemStyle ] ] [ text (t (PartnerEventsEmptyText partner.name)) ]
        , div [ css [] ] [ text "[fFf] Map" ]
        ]


viewContactDetails : Maybe String -> Data.PlaceCal.Partners.Contact -> Html msg
viewContactDetails maybeUrl contactDetails =
    address []
        [ if String.length contactDetails.telephone > 0 then
            p [css [ contactItemStyle ]] [ text contactDetails.telephone ]

          else
            text ""
        , if String.length contactDetails.email > 0 then
            p
                [ css [ contactItemStyle ] ]
                [ a
                    [ href ("mailto:" ++ contactDetails.email)
                    , css [ linkStyle ]
                    ]
                    [ text contactDetails.email
                    ]
                ]

          else
            text ""
        , case maybeUrl of
            Just url ->
                p [css [ contactItemStyle ]] [ a [ href url, target "_blank", css [ linkStyle ] ] [ text url ] ]

            Nothing ->
                text ""
        ]


viewAddress : Maybe Data.PlaceCal.Partners.Address -> Html msg
viewAddress maybeAddress =
    case maybeAddress of
        Just addressFields ->
            address []
                [ p [ css [ contactItemStyle ] ] [ text addressFields.streetAddress ]
                , p [ css [ contactItemStyle ] ]
                    [ text addressFields.addressRegion
                    , text ", "
                    , text addressFields.postalCode
                    ]
                ]

        Nothing ->
            p [ css [ contactItemStyle ] ] [ text (t PartnerAddressEmptyText) ]



---------
-- Styles
---------


descriptionStyle : Style
descriptionStyle =
    batch
        [ normalFirstParagraphStyle
        , withMediaTabletLandscapeUp
            [ margin2 (rem 0) auto
            , maxWidth (px 636)
            ]
        , withMediaTabletPortraitUp
            [ margin2 (rem 0) (rem 2) ]
        ]


contactWrapperStyle : Style
contactWrapperStyle =
    batch
        [ withMediaTabletPortraitUp
            [ displayFlex ]
        ]


contactSectionStyle : Style
contactSectionStyle =
    batch
        [ withMediaTabletPortraitUp
            [ width (pct 50), marginTop (rem -2) ]
        ]


contactHeadingStyle : Style
contactHeadingStyle =
    -- Temp style so I can see it
    batch [ color Theme.Global.pink ]


contactItemStyle : Style
contactItemStyle =
    batch
        [ textAlign center
        , fontStyle normal
        , marginBlockStart (rem 0)
        , marginBlockEnd (rem 0)
        ]
