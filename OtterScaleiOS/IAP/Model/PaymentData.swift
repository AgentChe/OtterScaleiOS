//
//  PaymentData.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

public struct PaymentData: Codable {
    let subscriptions: SubscriptionsPaymentData
    let nonConsumables: NonConsumablesPaymentData
}

public struct SubscriptionsPaymentData: Codable {
    let appleAppStore: [SubscriptionPaymentProduct]
    let googlePlay: [SubscriptionPaymentProduct]
}

public struct SubscriptionPaymentProduct: Codable {
    enum Status: String, Codable {
        case refund, trial, paid
    }
    
    let productID: String
    let valid: Bool
    let expiration: String
    let status: Status
    let renewing: Bool
}

public struct NonConsumablesPaymentData: Codable {
    let appleAppStore: [NonConsumablePaymentProduct]
    let googlePlay: [NonConsumablePaymentProduct]
}

public struct NonConsumablePaymentProduct: Codable {
    let productID: String
    let valid: Bool
}
