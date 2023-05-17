//
//  ADAttributionsManager.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

protocol AnalyticsManagerProtocol {
    func syncADServiceToken(adServiceToken: ADServiceTokenProtocol, mapper: SendADServiceTokenResponseProtocol)
    func registerInstall(infoHelper: InfoHelperProtocol, completion: (() -> Void)?)
}

final class AnalyticsManager: AnalyticsManagerProtocol {
    private let apiEnvironment: APIEnvironmentProtocol
    private let storage: StorageProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    private let analyticsMediator: AnalyticsMediatorProtocol
    
    private lazy var operations = [String: APIOperationProtocol]()
    private lazy var operationWrapper = APIOperationWrapper()
    
    init(apiEnvironment: APIEnvironmentProtocol,
         storage: StorageProtocol,
         analyticsMediator: AnalyticsMediatorProtocol) {
        self.apiEnvironment = apiEnvironment
        self.storage = storage
        self.requestDispatcher = RequestDispatcher(environment: apiEnvironment,
                                                   networkSession: NetworkSession())
        self.analyticsMediator = analyticsMediator
    }
}

// MARK: Internal
extension AnalyticsManager {
    func syncADServiceToken(
        adServiceToken: ADServiceTokenProtocol = ADServiceToken(),
        mapper: SendADServiceTokenResponseProtocol = SendADServiceTokenResponse()
    ) {
        guard let token = adServiceToken.attributionToken() else {
            return
        }
        
        let request = SendADServiceTokenRequest(apiKey: apiEnvironment.apiKey,
                                                anonymousId: storage.anonymousID,
                                                token: token)
        let operation = APIOperation(endPoint: request)
        
        let key = "send_ad_service_token_request"
        
        operations[key] = operation
        
        operationWrapper.execute(operation: operation, dispatcher: requestDispatcher) { [weak self] response in
            guard let self = self else {
                return
            }
            
            if let response = response, let model = mapper.map(response: response) {
                self.analyticsMediator.notifyAbout(model: model)
            } else {
                self.analyticsMediator.notifyAbout(model: nil)
            }
            
            self.operations.removeValue(forKey: key)
        }
    }
    
    func registerInstall(infoHelper: InfoHelperProtocol = InfoHelper(), completion: (() -> Void)? = nil) {
        let request = RegisterInstallRequest(apiKey: apiEnvironment.apiKey,
                                             anonymousID: storage.anonymousID,
                                             currency: infoHelper.currencyCode ?? "",
                                             country: infoHelper.countryCode ?? "",
                                             locale: infoHelper.locale ?? "",
                                             idfv: infoHelper.idfv ?? "")
        let operation = APIOperation(endPoint: request)
        
        let key = "register_install_request"
        
        operations[key] = operation
        
        operationWrapper.execute(operation: operation, dispatcher: requestDispatcher) { [weak self] response in
            self?.operations.removeValue(forKey: key)
            
            completion?()
        }
    }
}
