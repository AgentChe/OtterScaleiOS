//
//  OtterScaleInteractor.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 16.01.2022.
//

final class OtterScaleInteractor {
    private lazy var storage = Storage()
    private lazy var launches = NumberLaunches()
    
    private var apiEnvironment: APIEnvironmentProtocol!
    
    private lazy var adAttributionsManager = ADAttributionsManager(apiEnvironment: apiEnvironment,
                                                                   storage: storage)
    private lazy var iapManager = IAPManager(apiEnvironment: apiEnvironment,
                                             storage: storage)
}

// MARK: Public
extension OtterScaleInteractor {
    func initialize(host: String, apiKey: String) {
        launches.launch()
        
        apiEnvironment = APIEnvironment(host: host, apiKey: apiKey)
        
        initializeForFirstLaunch()
        initializeForColdLaunch()
    }
    
    func updatePaymentData(completion: ((PaymentData?) -> Void)? = nil) {
        iapManager.obtainAppStoreValidateResult { [weak self] result in
            guard let self = self else {
                return
            }
            
            if let result = result {
                self.storage.otterScaleUserID = result.otterScaleID
                self.storage.paymentData = result.paymentData
            }
            
            completion?(result?.paymentData)
        }
    }
}

// MARK: Private
private extension OtterScaleInteractor {
    func initializeForFirstLaunch() {
        guard launches.isFirstLaunch() else {
            return
        }
        
        adAttributionsManager.syncADServiceToken()
    }
    
    func initializeForColdLaunch() {
        validateAppStoreReceipt()
    }
    
    func validateAppStoreReceipt() {
        iapManager.validateAppStoreReceipt { [weak self] result in
            guard let self = self else {
                return
            }
            
            if let result = result {
                self.storage.otterScaleUserID = result.otterScaleID
                self.storage.paymentData = result.paymentData
            }
        }
    }
}
