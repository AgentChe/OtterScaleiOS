//
//  AppStoreReceiptFetcher.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

protocol AppStoreReceiptFetcherProtocol {
    init(appStoreReceipt: AppStoreReceiptProtocol)
    
    func fetch(completion: @escaping (String?) -> Void)
}

final class AppStoreReceiptFetcher: AppStoreReceiptFetcherProtocol {
    deinit {
        refreshRequest?.cancel()
        refreshRequest = nil
    }
    
    private var refreshRequest: AppStoreReceiptRefreshRequest?
    
    private let appStoreReceipt: AppStoreReceiptProtocol
    
    init(appStoreReceipt: AppStoreReceiptProtocol = AppStoreReceipt()) {
        self.appStoreReceipt = appStoreReceipt
    }
}

// MARK: Internal
extension AppStoreReceiptFetcher {
    func fetch(completion: @escaping (String?) -> Void) {
        if let receiptData = appStoreReceipt.appStoreReceiptData() {
            let encoded = self.encode(data: receiptData)
            completion(encoded)
        } else {
            refreshRequest = AppStoreReceiptRefreshRequest { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success:
                    if let receiptData = self.appStoreReceipt.appStoreReceiptData() {
                        let encoded = self.encode(data: receiptData)
                        completion(encoded)
                    }
                case .error:
                    completion(nil)
                }
                
                self.refreshRequest = nil
            }
            
            refreshRequest?.refresh()
        }
    }
}

// MARK: Private
extension AppStoreReceiptFetcher {
    func encode(data: Data) -> String {
        data.base64EncodedString()
    }
}
