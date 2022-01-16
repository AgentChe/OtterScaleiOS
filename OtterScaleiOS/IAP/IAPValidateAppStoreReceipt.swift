//
//  IAPValidateAppStoreReceipt.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

protocol IAPValidateAppStoreReceiptProtocol {
    func validate(appStoreReceipt: String, completion: ((AppStoreValidateResult?) -> Void)?)
}

final class IAPValidateAppStoreReceipt: IAPValidateAppStoreReceiptProtocol {
    deinit {
        operation = nil
    }
    
    private var operation: APIOperation?
    
    private let storage: StorageProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    private let apiEnvironment: APIEnvironmentProtocol
    private let mapper: ValidateAppStoreReceiptResponseProtocol
    
    init(storage: StorageProtocol,
         requestDispatcher: RequestDispatcherProtocol,
         apiEnvironment: APIEnvironmentProtocol,
         mapper: ValidateAppStoreReceiptResponseProtocol = ValidateAppStoreReceiptResponse()) {
        self.storage = storage
        self.requestDispatcher = requestDispatcher
        self.apiEnvironment = apiEnvironment
        self.mapper = mapper
    }
}

// MARK: Internal
extension IAPValidateAppStoreReceipt {
    func validate(appStoreReceipt: String, completion: ((AppStoreValidateResult?) -> Void)?) {
        let request = ValidateAppStoreReceiptRequest(apiKey: apiEnvironment.apiKey,
                                                     anonymousID: storage.anonymousID,
                                                     externalUserID: storage.externalUserID,
                                                     otterScaleUserID: storage.otterScaleUserID,
                                                     appStoreReceipt: appStoreReceipt)
        
        operation = APIOperation(endPoint: request)
        
        operation?.execute(dispatcher: requestDispatcher) { [weak self] result in
            guard let self = self else {
                return
            }
            
            guard
                let response = result,
                let appStoreValidateResult = self.mapper.map(response: response)
            else {
                completion?(nil)
                return
            }
            
            completion?(appStoreValidateResult)
            
            self.operation = nil
        }
    }
}
