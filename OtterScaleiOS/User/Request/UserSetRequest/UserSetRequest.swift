//
//  UserSetRequest.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 16.01.2022.
//

struct UserSetRequest: EndPoint {
    let apiKey: String
    let anonymousID: String
    let externalUserID: String?
    let otterScaleUserID: String?
    let userParameters: [String: Any]
    
    var path: String {
        "/api/v1/sdk/set"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: [String : Any] {
        var params: [String: Any] = [
            "_api_key": apiKey,
            "anonymous_id": anonymousID,
            "parameters": userParameters
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
