//
//  IAPTransactionHandler.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 18.01.2022.
//

protocol IAPTransactionHandlerProtocol: IAPTransactionDelegate {
    init(iapManager: IAPManagerProtocol)
}

final class IAPTransactionHandler: IAPTransactionHandlerProtocol {
    private let iapManager: IAPManagerProtocol
    
    init(iapManager: IAPManagerProtocol) {
        self.iapManager = iapManager
    }
}

// MARK: IAPTransactionDelegate
extension IAPTransactionHandler {
    func retrieved(transactions: [IAPPaymentTransaction]) {
        iapManager.validateAppStoreReceipt(completion: nil)
    }
}
