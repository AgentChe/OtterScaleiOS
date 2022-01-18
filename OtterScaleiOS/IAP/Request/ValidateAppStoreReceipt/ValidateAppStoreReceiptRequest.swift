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
    let prices: [IAPPrice]?
    
    var path: String {
        "/api/v1/sdk/receipt_ios"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: [String : Any] {
        var params: [String: Any] = [
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
        
        if let prices = prices, !prices.isEmpty {
            let array = prices.map { price -> [String: Any] in
                [
                    "product_id": price.productID,
                    "price": price.price,
                    "currency": price.currency
                ]
            }
            params["prices"] = array
        }
        
        return params
    }
    
    var headers: [String : String] {
        [
            "Content-Type": "application/json",
        ]
    }
}
