module PageFooter exposing (viewPageFooter)

import Html.Styled exposing (Html, a, button, div, footer, form, h1, input, label, li, nav, p, span, text, ul)
import Html.Styled.Attributes exposing (css, href, target, type_)


viewPageFooter : Html msg
viewPageFooter =
    footer []
        [ viewPageFooterNavigation ""
        , viewPageFooterLogos
        , viewPageFooterSignup "Sign up to our email list for updates" "Sign up"
        , viewPageFooterInfo "The Trans Dimension, c/o Gendered Intelligence" "Address and contact info"
        , viewPageFooterCredit "Built using Placecal"
        ]


viewPageFooterNavigation : String -> Html msg
viewPageFooterNavigation listItems =
    nav []
        [ ul []
            [ li [] [ text "Item 1" ]
            , li [] [ text "Item 2" ]
            , li [] [ text "Item 3" ]
            ]
        ]


viewPageFooterLogos : Html msg
viewPageFooterLogos =
    div []
        [ ul []
            [ li [] [ text "GFSC logo" ]
            , li [] [ text "GI logo" ]
            , li [] [ text "Comic relief logo" ]
            ]
        ]


viewPageFooterSignup : String -> String -> Html msg
viewPageFooterSignup copyText buttonText =
    form []
        [ label []
            [ span [] [ text copyText ]
            , input [ type_ "email" ] []
            ]
        , button [ type_ "submit" ] [ text buttonText ]
        ]


viewPageFooterInfo : String -> String -> Html msg
viewPageFooterInfo nameInfo contactInfo =
    div []
        [ p [] [ text nameInfo ]
        , p [] [ text contactInfo ]
        ]


viewPageFooterCredit : String -> Html msg
viewPageFooterCredit creditText =
    p []
        [ a [ href "http://placecal.org", target "_blank" ] [ text creditText ]
        ]
