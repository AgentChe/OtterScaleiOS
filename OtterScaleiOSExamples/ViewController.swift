//
//  ViewController.swift
//  OtterScaleiOSExamples
//
//  Created by Андрей Чернышев on 10.01.2022.
//

import UIKit
import OtterScaleiOS
import SwiftyStoreKit

final class ViewController: UIViewController {
    lazy var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        OtterScale.shared.initialize(host: "https://api.korrekted.com", apiKey: "oCrVwRgejQISV560")
        
        mainView.setUserIDButton.addTarget(self, action: #selector(setUserIDTapped), for: .touchUpInside)
        mainView.purchase1Button.addTarget(self, action: #selector(buyLifetimeProductTapped), for: .touchUpInside)
        mainView.purchase2Button.addTarget(self, action: #selector(buyMonthlyProductTapped), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
        mainView.forceSync.addTarget(self, action: #selector(forceSyncTapped), for: .touchUpInside)
        mainView.setPropertiesButton.addTarget(self, action: #selector(setPropertiesTapped), for: .touchUpInside)
        mainView.getOtterScaleIDButton.addTarget(self, action: #selector(getOtterScaleIDTapped), for: .touchUpInside)
        mainView.getPaymentDataButton.addTarget(self, action: #selector(getPaymentDataTapped), for: .touchUpInside)
        mainView.getSubscriptionsButton.addTarget(self, action: #selector(getSubscriptionsTapped), for: .touchUpInside)
        mainView.getNonConsumablesButton.addTarget(self, action: #selector(getNonConsumablesTapped), for: .touchUpInside)
        
        addHideKeyboardAction()
        
        OtterScale.shared.add(delegate: self)
    }
}

// MARK: Private
private extension ViewController {
    @objc
    func setUserIDTapped() {
        let text = mainView.userIDTextField.text ?? ""
        
        guard !text.isEmpty else {
            return
        }
        
        OtterScale.shared.set(userID: text)
    }
    
    @objc
    func buyLifetimeProductTapped() {
        SwiftyStoreKit.purchaseProduct("exam.nursing.lifetime") { result in
            switch result {
            case .success(let details):
                print(details)
            case .error(let error):
                print(error)
            }
        }
    }
    
    @objc
    func buyMonthlyProductTapped() {
        SwiftyStoreKit.purchaseProduct("exam.nursing.monthly") { result in
            switch result {
            case .success(let details):
                print(details)
            case .error(let error):
                print(error)
            }
        }
    }
    
    @objc
    func restoreTapped() {
        SwiftyStoreKit.restorePurchases { result in
            print(result)
        }
    }
    
    @objc
    func setPropertiesTapped() {
        let text = mainView.propertiesTextField.text ?? ""
        let array = text.split(separator: ".")
        
        var dict = [String: String]()
        
        array.forEach { element in
            let array = element.split(separator: ",")

            guard array.count == 2 else {
                return
            }
            
            dict[String(array[0])] = String(array[1])
        }
        
        OtterScale.shared.set(properties: dict)
    }
    
    @objc
    func forceSyncTapped() {
        OtterScale.shared.updatePaymentData(forceValidation: true) { data in
            print(data)
        }
    }
    
    @objc
    func getOtterScaleIDTapped() {
        let id = OtterScale.shared.getInternalID()
        print(id)
    }
    
    @objc
    func getPaymentDataTapped() {
        let data = OtterScale.shared.getPaymentData()
        print(data)
    }
    
    @objc
    func getSubscriptionsTapped() {
        let subscriptions = OtterScale.shared.getSubscriptions()
        print(subscriptions)
    }
    
    @objc
    func getNonConsumablesTapped() {
        let nonConsumables = OtterScale.shared.getNonConsumables()
        print(nonConsumables)
    }
    
    func addHideKeyboardAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboardAction() {
        view.endEditing(true)
    }
}

// MARK: OtterScaleReceiptValidationDelegate
extension ViewController: OtterScaleReceiptValidationDelegate {
    func otterScaleDidValidatedReceipt(with result: PaymentData?) {
        print(result)
    }
}
