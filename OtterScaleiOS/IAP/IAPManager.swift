//
//  IAPManager.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

import StoreKit

protocol IAPManagerProtocol {
    func fetchAppStoreReceipt(completion: @escaping (String?) -> Void)
    func validateAppStoreReceipt(completion: ((AppStoreValidateResult?) -> Void)?)
}

final class IAPManager: IAPManagerProtocol {
    private let apiEnvironment: APIEnvironmentProtocol
    private var storage: StorageProtocol
    private let appStoreReceiptFetcher: AppStoreReceiptFetcherProtocol
    private let appStoreReceiptValidator: IAPValidateAppStoreReceiptProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    
    init(apiEnvironment: APIEnvironmentProtocol,
         storage: StorageProtocol,
         appStoreReceiptFetcher: AppStoreReceiptFetcherProtocol,
         appStoreReceiptValidator: IAPValidateAppStoreReceiptProtocol,
         requestDispatcher: RequestDispatcherProtocol) {
        self.apiEnvironment = apiEnvironment
        self.storage = storage
        self.appStoreReceiptFetcher = appStoreReceiptFetcher
        self.appStoreReceiptValidator = appStoreReceiptValidator
        self.requestDispatcher = requestDispatcher
    }
    
    convenience init(apiEnvironment: APIEnvironmentProtocol,
                     storage: StorageProtocol) {
        let requestDispatcher = RequestDispatcher(environment: apiEnvironment,
                                                  networkSession: NetworkSession())
        
        let appStoreReceiptValidator = IAPValidateAppStoreReceipt(storage: storage,
                                                                  requestDispatcher: requestDispatcher,
                                                                  apiEnvironment: apiEnvironment)
        
        self.init(apiEnvironment: apiEnvironment,
                  storage: storage,
                  appStoreReceiptFetcher: AppStoreReceiptFetcher(),
                  appStoreReceiptValidator: appStoreReceiptValidator,
                  requestDispatcher: requestDispatcher)
    }
}

// MARK: Internal
extension IAPManager {
    func fetchAppStoreReceipt(completion: @escaping (String?) -> Void) {
        appStoreReceiptFetcher.fetch(completion: completion)
    }
    
    func validateAppStoreReceipt(completion: ((AppStoreValidateResult?) -> Void)? = nil) {
        let validateCompletion: (AppStoreValidateResult?) -> Void = { [weak self] result in
            if let self = self, let result = result {
                self.storage.otterScaleUserID = result.otterScaleID
                self.storage.paymentData = result.paymentData
            }
            
            completion?(result)
        }
        
        fetchAppStoreReceipt { [weak self] appStoreReceipt in
            guard let self = self, let appStoreReceipt = appStoreReceipt else {
                completion?(nil)
                return
            }
            
            self.appStoreReceiptValidator.validate(appStoreReceipt: appStoreReceipt, completion: validateCompletion)
        }
    }
}
