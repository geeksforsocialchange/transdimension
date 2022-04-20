module Theme.Global exposing (black, blue, blueBackgroundStyle, buttonStyle, buttonWrapperStyle, checkboxStyle, containerContent, containerPage, contentContainerStyle, contentWrapperStyle, darkBlue, darkBlueBackgroundStyle, darkPurple, generateId, globalStyles, goBackButtonStyle, goBackStyle, gridStyle, hrStyle, introTextLargeStyle, introTextSmallStyle, lightPink, linkStyle, maxMobile, normalFirstParagraphStyle, oneColumn, pink, pinkBackgroundStyle, purple, smallFloatingTitleStyle, smallInlineTitleStyle, textBoxInvisibleStyle, textBoxPinkStyle, textBoxStyle, textInputErrorStyle, textInputStyle, threeColumn, twoColumn, verticalSpacing, viewBackButton, viewCheckbox, viewFloatingButton, white, whiteBackgroundStyle, withMediaLargeDesktopUp, withMediaMediumDesktopUp, withMediaMobileOnly, withMediaSmallDesktopUp, withMediaTabletLandscapeUp, withMediaTabletPortraitUp)

import Css exposing (Color, Style, absolute, after, alignItems, auto, backgroundColor, backgroundImage, backgroundPosition, backgroundRepeat, backgroundSize, batch, before, block, borderBox, borderColor, borderRadius, borderStyle, borderWidth, bottom, boxSizing, calc, center, checked, color, content, cursor, display, displayFlex, em, firstChild, fitContent, flexDirection, flexWrap, focus, fontFamilies, fontSize, fontStyle, fontWeight, height, hex, hidden, int, italic, justifyContent, left, letterSpacing, lineHeight, margin, margin2, margin4, marginBlockEnd, marginBlockStart, marginRight, marginTop, maxWidth, minus, noRepeat, none, outline, overflow, padding, padding2, padding4, paddingBottom, paddingLeft, paddingRight, paddingTop, pct, plus, pointer, position, property, px, relative, rem, repeat, right, row, sansSerif, solid, start, textAlign, textDecoration, textTransform, top, transparent, uppercase, url, vw, width, wrap, zIndex, zero)
import Css.Global exposing (adjacentSiblings, descendants, global, typeSelector)
import Css.Media as Media exposing (only, screen, withMedia)
import Html.Styled exposing (Html, a, div, input, label, p, span, text)
import Html.Styled.Attributes exposing (css, for, href, id, type_, value)
import Html.Styled.Events exposing (onCheck)



-- Brand colours


darkBlue : Color
darkBlue =
    hex "040F39"


pink : Color
pink =
    hex "FF7AA7"


lightPink : Color
lightPink =
    hex "FFBCD3"


purple : Color
purple =
    hex "814470"


darkPurple : Color
darkPurple =
    hex "683a65"


blue : Color
blue =
    hex "53C3FF"


white : Color
white =
    hex "FFFFFF"



-- Accent colours
-- Text and background colours


black : Color
black =
    hex "000000"



-- Breakpoints


maxMobile : Float
maxMobile =
    600


withMediaMobileOnly : List Style -> Style
withMediaMobileOnly =
    withMedia [ only screen [ Media.maxWidth (px (maxMobile - 1)) ] ]


withMediaTabletPortraitUp : List Style -> Style
withMediaTabletPortraitUp =
    withMedia [ only screen [ Media.minWidth (px maxMobile) ] ]


maxTabletPortrait : Float
maxTabletPortrait =
    900


withMediaTabletLandscapeUp : List Style -> Style
withMediaTabletLandscapeUp =
    withMedia [ only screen [ Media.minWidth (px maxTabletPortrait) ] ]


maxTabletLandscape : Float
maxTabletLandscape =
    1200


withMediaSmallDesktopUp : List Style -> Style
withMediaSmallDesktopUp =
    withMedia [ only screen [ Media.minWidth (px maxTabletLandscape) ] ]


maxSmallDesktop : Float
maxSmallDesktop =
    1500


withMediaMediumDesktopUp : List Style -> Style
withMediaMediumDesktopUp =
    withMedia [ only screen [ Media.minWidth (px maxSmallDesktop) ] ]


maxMediumDesktop : Float
maxMediumDesktop =
    2200


withMediaLargeDesktopUp : List Style -> Style
withMediaLargeDesktopUp =
    withMedia [ only screen [ Media.minWidth (px maxMediumDesktop) ] ]


pinkBackgroundStyle : Style
pinkBackgroundStyle =
    backgroundColor pink


blueBackgroundStyle : Style
blueBackgroundStyle =
    backgroundColor blue


darkBlueBackgroundStyle : Style
darkBlueBackgroundStyle =
    batch
        [ backgroundColor darkBlue
        , borderColor pink
        , borderStyle solid
        , borderWidth (px 1)
        ]


whiteBackgroundStyle : Style
whiteBackgroundStyle =
    batch
        [ backgroundColor white
        , color darkBlue
        ]


viewFloatingButton : String -> String -> Style -> Html msg
viewFloatingButton link label backgroundStyle =
    p [ css [ buttonWrapperStyle ] ]
        [ a
            [ href link
            , css [ buttonStyle, backgroundStyle ]
            ]
            [ text label ]
        ]


buttonWrapperStyle : Style
buttonWrapperStyle =
    batch
        [ margin2 (rem 1) auto
        , display block
        , position absolute
        , bottom (rem -2)
        , textAlign center
        , width (pct 100)
        ]


buttonStyle : Style
buttonStyle =
    batch
        [ backgroundColor white
        , color darkBlue
        , textDecoration none
        , padding4 (rem 0.375) (rem 1.25) (rem 0.5) (rem 1.25)
        , borderRadius (rem 0.3)
        , fontWeight (int 600)
        , marginRight (rem 1.75)
        , fontSize (rem 1.2)
        ]


smallTitleStyle : Style
smallTitleStyle =
    batch
        [ textTransform uppercase
        , textAlign center
        , letterSpacing (px 1.9)
        ]


smallFloatingTitleStyle : Style
smallFloatingTitleStyle =
    batch
        [ smallTitleStyle
        , position absolute
        , top (rem -3)
        , width (calc (pct 100) minus (rem 2))
        , left (rem 1)
        , fontSize (rem 1.2)
        , color white
        ]


smallInlineTitleStyle : Style
smallInlineTitleStyle =
    batch
        [ smallTitleStyle
        , fontSize (rem 1)
        , marginBlockStart (em 2)
        , marginBlockEnd (em 1.6)
        ]


textBoxStyle : Style
textBoxStyle =
    batch
        [ borderRadius (rem 0.3)
        , boxSizing borderBox
        , padding2 (rem 1) (rem 0.75)
        , withMediaMediumDesktopUp
            [ paddingBottom (rem 2) ]
        , withMediaTabletPortraitUp
            [ paddingLeft (rem 1.5), paddingRight (rem 1.5) ]
        ]


textBoxPinkStyle : Style
textBoxPinkStyle =
    batch
        [ textBoxStyle
        , backgroundColor pink
        , color darkBlue
        ]


textBoxInvisibleStyle : Style
textBoxInvisibleStyle =
    batch
        [ backgroundColor darkBlue
        , color pink
        , textBoxStyle
        , paddingBottom (rem 0)
        , descendants
            [ typeSelector "h3" [ batch [ color pink, withMediaTabletLandscapeUp [ margin4 (rem 2) auto (rem 0) auto ] ] ]
            , typeSelector "p" [ batch [ color pink, withMediaTabletLandscapeUp [ margin4 (rem 2) auto (rem 0) auto ] ] ]
            ]
        ]


contentWrapperStyle : Style
contentWrapperStyle =
    batch
        [ borderRadius (rem 0.3)
        , backgroundColor darkBlue
        , borderColor pink
        , borderStyle solid
        , borderWidth (px 1)
        ]


contentContainerStyle : Style
contentContainerStyle =
    batch
        [ margin (rem 0.75)
        , withMediaMediumDesktopUp [ margin (rem 1.5) ]
        , withMediaTabletPortraitUp [ margin2 (rem 0) (rem 2) ]
        ]


introTextLargeStyle : Style
introTextLargeStyle =
    batch
        [ textAlign center
        , fontSize (rem 1.6)
        , lineHeight (rem 2)
        , fontStyle italic
        , fontWeight (int 500)
        , margin2 (rem 1) (rem 0.5)
        , withMediaTabletLandscapeUp
            [ fontSize (rem 2.5), lineHeight (rem 3.1), maxWidth (px 838), margin2 (rem 3) auto ]
        , withMediaTabletPortraitUp
            [ fontSize (rem 1.9), lineHeight (rem 2.1), margin2 (rem 1) (rem 1.5) ]
        ]


introTextSmallStyle : Style
introTextSmallStyle =
    batch
        [ textAlign center
        , margin2 (rem 1.5) (rem 0)
        , withMediaTabletLandscapeUp
            [ fontSize (rem 1.2), margin2 (rem 1.5) (rem 6.5) ]
        , withMediaTabletPortraitUp
            [ margin2 (rem 1.5) (rem 3.5) ]
        ]


viewBackButton : String -> String -> Html msg
viewBackButton link buttonText =
    p [ css [ goBackStyle ] ]
        [ a [ href link, css [ goBackButtonStyle ] ] [ text buttonText ] ]


goBackStyle : Style
goBackStyle =
    batch
        [ textAlign center
        , margin4 (rem 3) (rem 2) (rem 0) (rem 2)
        ]


goBackButtonStyle : Style
goBackButtonStyle =
    batch
        [ backgroundColor darkBlue
        , color white
        , textDecoration none
        , padding2 (rem 0.5) (rem 2)
        , fontSize (rem 1.2)
        , margin2 (rem 2) auto
        , textAlign center
        , borderColor pink
        , borderStyle solid
        , borderWidth (px 2)
        , borderRadius (rem 0.3)
        , fontWeight (int 600)
        ]


hrStyle : Style
hrStyle =
    batch
        [ borderColor pink
        , borderStyle solid
        , borderWidth (px 0.5)
        , margin2 (rem 2) (rem 0)
        ]


linkStyle : Style
linkStyle =
    batch
        [ color white
        , property "text-decoration-color" "#FF7AA7"
        ]



--- For overriding the markdown style when we don't want it...


normalFirstParagraphStyle : Style
normalFirstParagraphStyle =
    batch
        [ descendants
            [ typeSelector "p"
                [ batch
                    [ firstChild
                        [ fontSize (rem 1)
                        , marginBlockEnd (em 1)
                        , lineHeight (em 1.5)
                        , withMediaSmallDesktopUp [ fontSize (rem 1.2) ]
                        , withMediaTabletPortraitUp [ marginBlockStart (em 0) ]
                        ]
                    ]
                ]
            ]
        ]



-- Formfields


textInputStyle : Style
textInputStyle =
    batch
        [ backgroundColor darkBlue
        , borderColor pink
        , borderWidth (px 2)
        , borderStyle solid
        , borderRadius (rem 0.3)
        , padding2 (rem 0.5) (rem 1)
        , color white
        , outline none
        , focus [ borderColor white ]
        ]


textInputErrorStyle : Style
textInputErrorStyle =
    batch
        [ textInputStyle
        , backgroundColor pink
        , color darkBlue
        , borderColor white
        ]


viewCheckbox : String -> String -> Bool -> (Bool -> msg) -> List (Html msg)
viewCheckbox boxId labelText checkedValue update =
    [ label
        [ css
            [ if checkedValue == True then
                checkboxLabelCheckedStyle

              else
                checkboxLabelStyle
            ]
        , for boxId
        ]
        [ text labelText ]
    , input [ css [ checkboxStyle ], type_ "checkbox", id boxId, Html.Styled.Attributes.checked checkedValue, onCheck update ] []
    ]


checkboxLabelStyle : Style
checkboxLabelStyle =
    batch
        [ color pink
        , fontWeight (int 500)
        , displayFlex
        , flexDirection row
        , alignItems center
        , justifyContent center
        , margin (rem 0)
        , position relative
        , cursor pointer
        , after
            [ property "content" "\"\""
            , textInputStyle
            , padding (rem 0)
            , width (em 2)
            , height (em 2)
            , backgroundColor transparent
            , property "appearance" "none"
            , margin (rem 0.5)
            , display block
            ]
        ]


checkboxLabelCheckedStyle : Style
checkboxLabelCheckedStyle =
    batch
        [ checkboxLabelStyle
        , before
            [ display block
            , property "content" "\"\""
            , width (em 1.25)
            , height (em 1.25)
            , margin (em 1)
            , position absolute
            , top (px 0)
            , right (px 0)
            , backgroundColor pink
            , borderRadius (em 1)
            ]
        ]


checkboxStyle : Style
checkboxStyle =
    batch
        [ display none
        ]


{-| Injects a <style> tag into the body, and can target element or
class selectors anywhere, including outside the Elm app.
-}
globalStyles : Html msg
globalStyles =
    global
        [ typeSelector "body"
            [ backgroundColor darkBlue
            , color white
            , fontFamilies [ "covik-sans", sansSerif.value ]
            , fontWeight (int 400)
            , backgroundImage (url "/images/backgrounds/starfield-small-800.png")
            , backgroundRepeat repeat
            , backgroundSize (px 800)
            , withMediaMediumDesktopUp [ backgroundImage (url "/images/backgrounds/starfield-largest-1920.png"), backgroundSize (px 1920) ]
            , withMediaTabletLandscapeUp [ backgroundImage (url "/images/backgrounds/starfield-medium-1080.png"), backgroundSize (px 1080) ]
            ]
        , typeSelector "h1"
            [ color darkBlue
            ]
        , typeSelector "h2"
            [ color darkBlue
            ]
        , typeSelector "h3"
            [ color darkBlue
            ]
        , typeSelector "h4"
            [ color darkBlue
            ]
        , typeSelector "b"
            [ fontWeight (int 700)
            ]
        , typeSelector "p"
            [ adjacentSiblings
                [ typeSelector "p"
                    [ marginTop (rem 1)
                    ]
                ]
            ]
        , typeSelector "blockquote"
            [ adjacentSiblings
                [ typeSelector "blockquote"
                    [ marginTop (rem 1)
                    ]
                ]
            ]
        ]


containerPage : String -> List (Html msg) -> Html msg
containerPage pageTitle content =
    div
        [ id ("page-" ++ generateId pageTitle)
        , css [ margin2 zero auto, width (pct 100), overflow hidden ]
        ]
        content


containerContent : List (Html msg) -> Html msg
containerContent children =
    div [ css [ margin2 zero auto, Css.maxWidth (px 800), width (pct 100) ] ] children


gridStyle : Style
gridStyle =
    batch
        [ displayFlex
        , flexWrap wrap
        , alignItems start
        ]


{-| A flex row item width for a single column layout
oneColumn : Css.CalculatedLength (not exposed by <https://github.com/rtfeldman/elm-css/pull/519>)
-}
oneColumn =
    calc (pct 100) minus (rem 2)


{-| A flex row item width for a double column layout
twoColumn : Css.CalculatedLength
-}
twoColumn =
    calc (pct 50) minus (rem 2)


{-| A flex row item width for a triple column layout
threeColumn : Css.CalculatedLength
-}
threeColumn =
    calc (pct 33.33) minus (rem 2)


{-| A div with known vertical margin
-}
verticalSpacing : Float -> Html msg
verticalSpacing num =
    div [ css [ margin2 (rem num) zero ] ] []



-- Helpers


generateId : String -> String
generateId input =
    String.trim (String.replace " " "-" (String.toLower input))
