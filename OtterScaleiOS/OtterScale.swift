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
    
    func set(properties: [String: Any]) {
        interactor.set(properties: properties)
    }
    
    func getOtterScaleID() -> String {
        interactor.getOtterScaleID()
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
    
    func updatePaymentData(completion: ((PaymentData?) -> Void)? = nil) {
        interactor.updatePaymentData(completion: completion)
    }
}
