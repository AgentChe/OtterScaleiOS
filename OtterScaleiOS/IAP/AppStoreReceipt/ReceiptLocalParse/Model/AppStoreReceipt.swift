//
//  AppStoreReceipt.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 01.02.2022.
//

import Foundation

struct AppStoreReceipt: Equatable {
    let bundleId: String
    let applicationVersion: String
    let originalApplicationVersion: String
    let opaqueValue: Data
    let sha1Hash: Data
    let creationDate: Date
    let expirationDate: Date?
    let inAppPurchases: [InAppPurchase]
}
