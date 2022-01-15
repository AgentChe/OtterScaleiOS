//
//  AppStoreReceipt.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

protocol AppStoreReceiptProtocol {
    func appStoreReceiptData() -> Data?
}

final class AppStoreReceipt: AppStoreReceiptProtocol {
    func appStoreReceiptData() -> Data? {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return nil
        }

        return try? Data(contentsOf: url)
    }
}
