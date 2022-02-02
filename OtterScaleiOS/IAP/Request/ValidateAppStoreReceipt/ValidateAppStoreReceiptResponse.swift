//
//  ValidateAppStoreReceiptResponse.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

protocol ValidateAppStoreReceiptResponseProtocol {
    func map(response: Any) -> AppStoreValidateResult?
}

final class ValidateAppStoreReceiptResponse: ValidateAppStoreReceiptResponseProtocol {
    func map(response: Any) -> AppStoreValidateResult? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let internalUserID = data["internal_user_id"] as? String,
            let subscriptionsData = data["subscriptions"] as? [String: Any],
            let nonConsumablesData = data["non_consumables"] as? [String: Any],
            let paymentData = paymentData(subscriptionsData: subscriptionsData,
                                          nonConsumablesData: nonConsumablesData)
        else {
            return nil
        }
        
        return AppStoreValidateResult(internalUserID: internalUserID,
                                      paymentData: paymentData)
    }
}

// MARK: Private
private extension ValidateAppStoreReceiptResponse {
    func paymentData(subscriptionsData: [String: Any],
                            nonConsumablesData: [String: Any]) -> PaymentData? {
        PaymentData(subscriptions: subscriptions(from: subscriptionsData),
                    nonConsumables: nonConsumables(from: nonConsumablesData))
    }
    
    func subscriptions(from subscriptionsData: [String: Any]) -> SubscriptionsPaymentData {
        let appleAppStoreArray = subscriptionsData["apple_app_store"] as? [[String: Any]] ?? []
        let googlePlayArray = subscriptionsData["google_play"] as? [[String: Any]] ?? []
        
        let appleAppStore = appleAppStoreArray.compactMap { subscriptionPaymentProduct(from: $0) }
        let googlePlay = googlePlayArray.compactMap { subscriptionPaymentProduct(from: $0) }
        
        return SubscriptionsPaymentData(appleAppStore: appleAppStore,
                                        googlePlay: googlePlay)
    }
    
    func subscriptionPaymentProduct(from json: [String: Any]) -> SubscriptionPaymentProduct? {
        guard
            let productID = json["product_id"] as? String,
            let valid = json["valid"] as? Bool,
            let expiration = json["expiration"] as? String,
            let statusCode = json["status"] as? Int,
            let status = subscriptionPaymentProductStatus(at: statusCode),
            let renewing = json["renewing"] as? Bool
        else {
            return nil
        }
        
        return SubscriptionPaymentProduct(productID: productID,
                                          valid: valid,
                                          expiration: expiration,
                                          status: status,
                                          renewing: renewing)
    }
    
    func subscriptionPaymentProductStatus(at code: Int) -> SubscriptionPaymentProduct.Status? {
        switch code {
        case -1:
            return .refund
        case 0:
            return .trial
        case 1:
            return .paid
        default:
            return nil
        }
    }
    
    func nonConsumables(from nonConsumablesData: [String: Any]) -> NonConsumablesPaymentData {
        let appleAppStoreArray = nonConsumablesData["apple_app_store"] as? [[String: Any]] ?? []
        let googlePlayArray = nonConsumablesData["google_play"] as? [[String: Any]] ?? []
        
        let appleAppStore = appleAppStoreArray.compactMap { nonConsumablePaymentProduct(from: $0) }
        let googlePlay = googlePlayArray.compactMap { nonConsumablePaymentProduct(from: $0) }
        
        return NonConsumablesPaymentData(appleAppStore: appleAppStore,
                                         googlePlay: googlePlay)
    }
    
    func nonConsumablePaymentProduct(from json: [String: Any]) -> NonConsumablePaymentProduct? {
        guard
            let productID = json["product_id"] as? String,
            let valid = json["valid"] as? Bool
        else {
            return nil
        }
        
        return NonConsumablePaymentProduct(productID: productID,
                                           valid: valid)
    }
}
