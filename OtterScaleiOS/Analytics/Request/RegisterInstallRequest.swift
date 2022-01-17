//
//  RegisterInstallRequest.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 17.01.2022.
//

struct RegisterInstallRequest: EndPoint {
    let apiKey: String
    let anonymousID: String
    let currency: String
    let country: String
    let locale: String
    
    var path: String {
        "/api/v1/sdk/register_install"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any] {
        [
            "_api_key": apiKey,
            "anonymous_id": anonymousID,
            "currency": currency,
            "store_country": country,
            "locale": locale
        ]
    }
    
    var headers: [String: String] {
        [
            "Content-Type": "application/json",
        ]
    }
}
