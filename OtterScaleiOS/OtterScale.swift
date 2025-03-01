//
//  OtterScale.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 10.01.2022.
//

public final class OtterScale {
    public static let shared = OtterScale()
    
    private let interactor = OtterScaleInteractor()
}

// MARK: Facade
public extension OtterScale {
    func initialize(host: String, apiKey: String) {
        interactor.initialize(host: host, apiKey: apiKey)
    }
    
    func set(userID: String) {
        interactor.set(userID: userID)
    }
    
    func set(internalUserID: String) {
        interactor.set(internalUserID: internalUserID)
    }
    
    func set(properties: [String: Any]) {
        interactor.set(properties: properties)
    }
    
    func set(pushNotificationsToken: String) {
        interactor.set(pushNotificationsToken: pushNotificationsToken)
    }
    
    func getUserID() -> Int? {
        interactor.getUserID()
    }
    
    func getAnonymousID() -> String {
        interactor.getAnonymousID()
    }
    
    func getInternalID() -> String {
        interactor.getInternalID()
    }
    
    func getPaymentData() -> PaymentData? {
        interactor.getPaymentData()
    }
    
    func getSubscriptions() -> SubscriptionsPaymentData? {
        interactor.getSubscriptions()
    }
    
    func getNonConsumables() -> NonConsumablesPaymentData? {
        interactor.getNonConsumables()
    }
    
    func getUsedProducts() -> UsedProducts? {
        interactor.getUsedProducts()
    }
    
    func getUserSince() -> String? {
        interactor.getUserSince()
    }
    
    func getAccessValidTill() -> String? {
        interactor.getAccessValidTill()
    }
    
    func updatePaymentData(forceValidation: Bool,
                           completion: ((PaymentData?) -> Void)? = nil,
                           notifyMediator: Bool = true) {
        interactor.updatePaymentData(forceValidation: forceValidation,
                                     completion: completion,
                                     notifyMediator: notifyMediator)
    }
    
    func addReceiptValidation(delegate: OtterScaleReceiptValidationDelegate) {
        interactor.add(delegate: delegate)
    }
    
    func removeReceiptValidation(delegate: OtterScaleReceiptValidationDelegate) {
        interactor.remove(delegate: delegate)
    }
    
    func addAnalytics(delegate: AnalyticsDelegate) {
        interactor.add(delegate: delegate)
    }
    
    func removeAnalytics(delegate: AnalyticsDelegate) {
        interactor.remove(delegate: delegate)
    }
}
