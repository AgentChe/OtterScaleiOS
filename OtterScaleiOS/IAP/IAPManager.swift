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
    func obtainAppStoreValidateResult(mapper: ValidateAppStoreReceiptResponseProtocol,
                                      completion: ((AppStoreValidateResult?) -> Void)?)
}

final class IAPManager: IAPManagerProtocol {
    private let apiEnvironment: APIEnvironmentProtocol
    private let storage: StorageProtocol
    private let appStoreReceiptFetcher: AppStoreReceiptFetcherProtocol
    private let appStoreReceiptValidator: IAPValidateAppStoreReceiptProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    
    private lazy var operations = [String: Any]()
    
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
        fetchAppStoreReceipt { [weak self] appStoreReceipt in
            
            guard let self = self, let appStoreReceipt = appStoreReceipt else {
                completion?(nil)
                return
            }
            
            self.appStoreReceiptValidator.validate(appStoreReceipt: appStoreReceipt, completion: completion)
        }
    }
    
    func obtainAppStoreValidateResult(mapper: ValidateAppStoreReceiptResponseProtocol = ValidateAppStoreReceiptResponse(),
                                      completion: ((AppStoreValidateResult?) -> Void)? = nil) {
        let request = ObtainAppStoreValidateResultRequest(apiKey: apiEnvironment.apiKey,
                                                          anonymousID: storage.anonymousID,
                                                          externalUserID: storage.externalUserID,
                                                          otterScaleUserID: storage.otterScaleUserID)
        let operation = APIOperation(endPoint: request)
        
        let key = "obtain_app_store_validation_result_request"
        
        operations[key] = operation
        
        operation.execute(dispatcher: requestDispatcher) { [weak self] response in
            guard let self = self else {
                return
            }
            
            if let response = response, let result = mapper.map(response: response) {
                completion?(result)
            } else {
                completion?(nil)
            }
            
            self.operations.removeValue(forKey: key)
        }
    }
}
