module Copy.Keys exposing (Key(..))


type Key
    = SiteTitle
    | SiteStrapline
      --- Site Meta
    | IndexPageMetaTitle
    | IndexPageMetaDescription
      --- Site Header
    | SiteHeaderAskButton
    | SiteHeaderAskLink
      --- Site Footer
    | SiteFooterSignupText
    | SiteFooterSignupButton
    | SiteFooterInfoText
    | SiteFooterInfoContact
    | SiteFooterCredit
