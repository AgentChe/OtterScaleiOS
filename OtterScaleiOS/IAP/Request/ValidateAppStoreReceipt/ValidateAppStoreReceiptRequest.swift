//
//  ValidateAppStoreReceiptRequest.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

struct ValidateAppStoreReceiptRequest: EndPoint {
    let apiKey: String
    let anonymousID: String
    let externalUserID: String?
    let otterScaleUserID: String?
    let appStoreReceipt: String
    
    var path: String {
        "/api/v1/sdk/receipt_ios"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: [String : Any] {
        var params = [
            "_api_key": apiKey,
            "anonymous_id": anonymousID,
            "receipt": appStoreReceipt
        ]
        
        if let externalUserID = externalUserID {
            params["external_user_id"] = externalUserID
        }
        
        if let otterScaleUserID = otterScaleUserID {
            params["otterscale_user_id"] = otterScaleUserID
        }
        
        return params
    }
    
    var headers: [String : String] {
        [:]
    }
}
