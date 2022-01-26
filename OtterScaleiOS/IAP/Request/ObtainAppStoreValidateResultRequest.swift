//
//  ObtainPaymentDataRequest.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 16.01.2022.
//

struct ObtainAppStoreValidateResultRequest: EndPoint {
    let apiKey: String
    let externalUserID: String?
    let otterScaleUserID: String?
    
    var path: String {
        "/api/v1/sdk/payment_data"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: [String : Any] {
        var params = [
            "_api_key": apiKey
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
        [
            "Content-Type": "application/json",
        ]
    }
}
