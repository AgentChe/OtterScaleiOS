//
//  SendADServiceTokenRequest.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

struct SendADServiceTokenRequest: EndPoint {
    let apiKey: String
    let anonymousId: String
    let token: String
    
    var path: String {
        "/api/v1/sdk/adservices_token"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: [String : Any] {
        [
            "_api_key": apiKey,
            "anonymous_id": anonymousId,
            "token": token,
            "await_response": true
        ]
    }
    
    var headers: [String : String] {
        [
            "Content-Type": "application/json",
        ]
    }
}
