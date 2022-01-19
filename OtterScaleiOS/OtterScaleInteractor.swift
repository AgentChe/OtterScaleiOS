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
    
    private lazy var analyticsManager = AnalyticsManager(apiEnvironment: apiEnvironment,
                                                              storage: storage)
    private lazy var iapManager = IAPManager(apiEnvironment: apiEnvironment,
                                             storage: storage)
    private lazy var userManager = UserManager(apiEnvironment: apiEnvironment,
                                               storage: storage)
    private lazy var iapPaymentsObserver = IAPPaymentsObserver(iapManager: iapManager)
}

// MARK: Internal
extension OtterScaleInteractor {
    func initialize(host: String, apiKey: String) {
        launches.launch()
        
        apiEnvironment = APIEnvironment(host: host, apiKey: apiKey)
        
        startPaymentsObserve()
        initializeForFirstLaunch()
        initializeForColdLaunch()
    }
    
    func set(userID: String) {
        userManager.set(userID: userID) { [weak self] success in
            guard let self = self, success else {
                return
            }
            
            self.updatePaymentData()
        }
    }
    
    func set(properties: [String: Any]) {
        userManager.set(properties: properties)
    }
    
    func getOtterScaleID() -> String {
        storage.otterScaleUserID ?? storage.anonymousID
    }
    
    func getPaymentData() -> PaymentData? {
        storage.paymentData
    }
    
    func getSubscriptions() -> SubscriptionsPaymentData? {
        storage.paymentData?.subscriptions
    }
    
    func getNonConsumables() -> NonConsumablesPaymentData? {
        storage.paymentData?.nonConsumables
    }
    
    func updatePaymentData(forceValidation: Bool = false,
                           completion: ((PaymentData?) -> Void)? = nil) {
        let finish: (AppStoreValidateResult?) -> Void = { result in
            completion?(result?.paymentData)
        }
        
        if forceValidation {
            iapManager.validateAppStoreReceipt(completion: finish)
        } else {
            iapManager.obtainAppStoreValidateResult(completion: finish)
        }
    }
}

// MARK: Private
private extension OtterScaleInteractor {
    func initializeForFirstLaunch() {
        guard launches.isFirstLaunch() else {
            return
        }
        
        analyticsManager.syncADServiceToken()
        analyticsManager.registerInstall()
    }
    
    func initializeForColdLaunch() {
        iapManager.validateAppStoreReceipt()
    }
    
    func startPaymentsObserve() {
        iapPaymentsObserver.observe()
    }
}
