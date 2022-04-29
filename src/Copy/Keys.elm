module Copy.Keys exposing (Key(..))


type Key
    = SiteTitle
    | SiteStrapline
    | SiteLogoSrc
    | PageMetaTitle String
      --- Header
    | HeaderMobileMenuButton
    | HeaderAskButton
    | HeaderAskLink
      --- Site Footer
    | FooterSocial
    | FooterSignupText
    | FooterSignupButton
    | FooterByLine
    | FooterInfoTitle
    | FooterInfoCharity
    | FooterInfoCompany
    | FooterInfoOffice
    | FooterCreditTitle
    | FooterCredit1Text
    | FooterCredit1Name
    | FooterCredit1Link
    | FooterCredit2Text
    | FooterCredit2Name
    | FooterCredit2Link
    | FooterCredit3Text
    | FooterCredit3Name
    | FooterCredit3Link
    | FooterCopyright
      --- Index Page
    | IndexTitle
    | IndexMetaDescription
    | IndexIntroTitle
    | IndexIntroMessage
    | IndexIntroButtonText
    | IndexFeaturedHeader
    | IndexFeaturedButtonText
    | IndexNewsHeader
    | IndexNewsButtonText
      --- About Page
    | AboutTitle
    | AboutMetaDescription
      --- Events Page
    | EventsTitle
    | EventsMetaDescription
    | EventsSummary
    | EventsSubHeading
    | EventsEmptyTextAll
    | EventsEmptyText
    | EventsFilterLabelToday
    | EventsFilterLabelTomorrow
    | EventsFilterLabelAll
      --- Event Page
    | EventTitle String
    | EventMetaDescription String String
    | BackToEventsLinkText
      --- Partners Page
    | PartnersTitle
    | PartnersMetaDescription
    | PartnersIntroSummary
    | PartnersIntroDescription
    | PartnersListEmpty
      --- Partner Page
    | PartnerTitle String
    | PartnerMetaDescription String String
    | PartnerContactsHeading
    | PartnerAddressHeading
    | PartnerAddressEmptyText
    | PartnerUpcomingEventsText String
    | PartnerEventsEmptyText String
    | BackToPartnersLinkText
      --- Join Page
    | JoinTitle
    | JoinMetaDescription
    | JoinSubtitle
    | JoinDescription
    | JoinFormInputNameLabel
    | JoinFormInputEmailLabel
    | JoinFormInputPhoneLabel
    | JoinFormInputAddressLabel
    | JoinFormInputJobLabel
    | JoinFormInputOrgLabel
    | JoinFormCheckboxesLabel
    | JoinFormCheckbox1
    | JoinFormCheckbox2
    | JoinFormInputMessageLabel
    | JoinFormInputMessagePlaceholder
    | JoinFormSubmitButton
      --- News Listing Page
    | NewsTitle
    | NewsEmptyText
    | NewsDescription
      --- News Single Article Page
    | NewsItemTitle String
    | NewsItemMetaDescription String String
    | NewsItemReturnButton
    | NewsItemReadMore String
      --- Privacy
    | PrivacyTitle
    | PrivacyMetaDescription
      --- 404
    | ErrorTitle
    | ErrorMessage
    | ErrorButtonText
