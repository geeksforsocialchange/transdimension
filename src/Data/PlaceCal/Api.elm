module Data.PlaceCal.Api exposing (fetchAndCachePlaceCalData, fetchSinglePlaceCalData)

import BackendTask
import BackendTask.Custom
import Constants
import FatalError
import Json.Decode
import Json.Encode


fetchAndCachePlaceCalData :
    String
    -> Json.Encode.Value
    -> (Json.Decode.Decoder a -> BackendTask.BackendTask { fatal : FatalError.FatalError, recoverable : BackendTask.Custom.Error } a)
fetchAndCachePlaceCalData collection query =
    BackendTask.Custom.run "fetchAndCachePlaceCalData"
        (Json.Encode.object
            [ ( "collection", Json.Encode.string collection )
            , ( "url", Json.Encode.string Constants.placecalApi )
            , ( "query", query )
            ]
        )
    >> BackendTask.quiet


fetchSinglePlaceCalData :
    String
    -> Json.Encode.Value
    -> (Json.Decode.Decoder a -> BackendTask.BackendTask { fatal : FatalError.FatalError, recoverable : BackendTask.Custom.Error } a)
fetchSinglePlaceCalData entityId query =
    BackendTask.Custom.run "fetchSinglePlaceCalData"
        (Json.Encode.object
            [ ( "entityId", Json.Encode.string entityId )
            , ( "url", Json.Encode.string Constants.placecalApi )
            , ( "query", query )
            ]
        )
    >> BackendTask.quiet
