//
//  AppStoreValidateResult.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

public struct AppStoreValidateResult {
    public let internalUserID: String?
    public let externalUserID: String?
    public let paymentData: PaymentData
    public let usedProducts: UsedProducts
    public let userSince: String?
    public let accessValidTill: String?
}
