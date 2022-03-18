//
//  OtterScaleReceiptValidationDelegate.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 19.01.2022.
//

public protocol OtterScaleReceiptValidationDelegate: AnyObject {
    func otterScaleDidValidatedReceipt(with result: AppStoreValidateResult?)
}
