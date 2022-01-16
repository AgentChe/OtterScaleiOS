//
//  ADAttributionsManager.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

protocol ADAttributionsManagerProtocol {
    init(apiEnvironment: APIEnvironmentProtocol,
         storage: StorageProtocol,
         adServiceToken: ADServiceTokenProtocol)
    
    func syncADServiceToken()
}

final class ADAttributionsManager: ADAttributionsManagerProtocol {
    private let apiEnvironment: APIEnvironmentProtocol
    private let adServiceToken: ADServiceTokenProtocol
    private let storage: StorageProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    
    private lazy var operations = [String: APIOperationProtocol]()
    
    init(apiEnvironment: APIEnvironmentProtocol,
         storage: StorageProtocol,
         adServiceToken: ADServiceTokenProtocol = ADServiceToken()) {
        self.apiEnvironment = apiEnvironment
        self.storage = storage
        self.adServiceToken = adServiceToken
        
        self.requestDispatcher = RequestDispatcher(environment: apiEnvironment,
                                                   networkSession: NetworkSession())
    }
}

// MARK: Internal
extension ADAttributionsManager {
    func syncADServiceToken() {
        guard let token = adServiceToken.attributionToken() else {
            return
        }
        
        let request = SendADServiceTokenRequest(apiKey: apiEnvironment.apiKey,
                                                anonymousId: storage.anonymousID,
                                                token: token)
        let operation = APIOperation(endPoint: request)
        
        let key = "send_ad_service_token_request"
        
        operations[key] = operation
        
        operation.execute(dispatcher: requestDispatcher) { [weak self] result in
            self?.operations.removeValue(forKey: key)
        }
    }
}
