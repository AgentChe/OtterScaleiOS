//
//  IAPTransactionObserver.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 18.01.2022.
//

import StoreKit

protocol IAPTransactionDelegate: AnyObject {
    func restored()
    func purchased()
}

protocol IAPTransactionObserverProtocol: SKPaymentTransactionObserver {
    init(delegate: IAPTransactionDelegate)
}

final class IAPTransactionObserver: NSObject, IAPTransactionObserverProtocol {
    private let delegate: IAPTransactionDelegate
    
    init(delegate: IAPTransactionDelegate) {
        self.delegate = delegate
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .restored:
                delegate.restored()
            case .purchased:
                delegate.purchased()
            default:
                break
            }
        }
    }
}
