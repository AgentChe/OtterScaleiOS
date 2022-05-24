//
//  Storage.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 14.01.2022.
//

protocol StorageProtocol {
    var anonymousID: String { get }
    var externalUserID: String? { get set }
    var internalUserID: String? { get set }
    var paymentData: PaymentData? { get set }
    var usedProducts: UsedProducts? { get set }
    var userSince: String? { get set }
    var accessValidTill: String? { get set }
}

final class Storage: StorageProtocol {
    enum Constants {
        static let externalUserIDKey = "otter.scale.ios_external_user_id_key"
        static let internalUserIDKey = "otter.scale.ios_internal_user_id_key"
        static let paymentDataKey = "otter.scale.ios_payment_data_key"
        static let usedProductsKey = "otter.scale.ios_used_products_key"
        static let userSinceKey = "otter.scale.ios_user_since"
        static let accessValidTillKey = "otter.scale.ios_access_valid_till"
    }
    
    private let anonymousIDStorage: AnonymousIDStorageProtocol
    
    init(anonymousIDStorage: AnonymousIDStorageProtocol = AnonymousIDStorage()) {
        self.anonymousIDStorage = anonymousIDStorage
    }
    
    var anonymousID: String {
        anonymousIDStorage.getAnonymousID()
    }
    
    var externalUserID: String? {
        set(value) {
            UserDefaults.standard.set(value, forKey: Constants.externalUserIDKey)
        }
        get {
            UserDefaults.standard.string(forKey: Constants.externalUserIDKey)
        }
    }
    
    var internalUserID: String? {
        set(value) {
            UserDefaults.standard.set(value, forKey: Constants.internalUserIDKey)
        }
        get {
            UserDefaults.standard.string(forKey: Constants.internalUserIDKey)
        }
    }
    
    var paymentData: PaymentData? {
        set(value) {
            guard let data = try? JSONEncoder().encode(value) else {
                return
            }
            
            UserDefaults.standard.set(data, forKey: Constants.paymentDataKey)
        }
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.paymentDataKey) else {
                return nil
            }
            
            return try? JSONDecoder().decode(PaymentData.self, from: data)
        }
    }
    
    var usedProducts: UsedProducts? {
        set(value) {
            guard let data = try? JSONEncoder().encode(value) else {
                return
            }
            
            UserDefaults.standard.set(data, forKey: Constants.usedProductsKey)
        }
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.usedProductsKey) else {
                return nil
            }
            
            return try? JSONDecoder().decode(UsedProducts.self, from: data)
        }
    }
    
    var userSince: String? {
        set(value) {
            UserDefaults.standard.set(value, forKey: Constants.userSinceKey)
        }
        get {
            UserDefaults.standard.string(forKey: Constants.userSinceKey)
        }
    }
    
    var accessValidTill: String? {
        set(value) {
            UserDefaults.standard.set(value, forKey: Constants.accessValidTillKey)
        }
        get {
            UserDefaults.standard.string(forKey: Constants.accessValidTillKey)
        }
    }
}
