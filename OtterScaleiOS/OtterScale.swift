//
//  OtterScale.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 10.01.2022.
//

public final class OtterScale {
    public static let shared = OtterScale()
    
    private lazy var storage = Storage()
    private lazy var launches = NumberLaunches()
    
    private var apiEnvironment: APIEnvironmentProtocol!
    
    private lazy var adAttributionsManager = ADAttributionsManager(apiEnvironment: apiEnvironment,
                                                                   storage: storage)
    private lazy var iapManager = IAPManager(apiEnvironment: apiEnvironment,
                                             storage: storage)
}

// MARK: Public
public extension OtterScale {
    func initialize(host: String, apiKey: String) {
        launches.launch()
        
        apiEnvironment = APIEnvironment(host: host, apiKey: apiKey)
        
        initializeForFirstLaunch()
        initializeForColdLaunch()
    }
    
    func forceSync(completion: ((PaymentData?) -> Void)? = nil) {
        iapManager.obtainAppStoreValidateResult { result in
            completion?(result?.paymentData)
        }
    }
}

// MARK: Private
private extension OtterScale {
    func initializeForFirstLaunch() {
        guard launches.isFirstLaunch() else {
            return
        }
        
        adAttributionsManager.syncADServiceToken()
    }
    
    func initializeForColdLaunch() {
        iapManager.validateAppStoreReceipt()
    }
}
