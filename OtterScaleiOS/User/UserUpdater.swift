//
//  UserUpdater.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 23.02.2022.
//

final class UserUpdater {
    private let manager: UserManagerProtocol
    private let mediator: IAPMediatorProtocol
    private let infoHelper: InfoHelperProtocol
    
    deinit {
        mediator.remove(delegate: self)
    }
    
    init(manager: UserManagerProtocol,
         mediator: IAPMediatorProtocol,
         infoHelper: InfoHelperProtocol = InfoHelper()) {
        self.manager = manager
        self.mediator = mediator
        self.infoHelper = infoHelper
    }
}

// MARK: Public
extension UserUpdater {
    func startTracking() {
        mediator.add(delegate: self)
    }
}

// MARK: OtterScaleReceiptValidationDelegate
extension UserUpdater: OtterScaleReceiptValidationDelegate {
    func otterScaleDidValidatedReceipt(with result: PaymentData?) {
        manager.set(properties: ["currency": infoHelper.currencyCode ?? "",
                                 "country": infoHelper.countryCode ?? "",
                                 "locale": infoHelper.locale ?? ""],
                    mapper: UserSetResponse(),
                    completion: nil)
    }
}
