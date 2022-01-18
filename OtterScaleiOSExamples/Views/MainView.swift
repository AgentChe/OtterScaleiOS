//
//  MainView.swift
//  OtterScaleiOSExamples
//
//  Created by Андрей Чернышев on 17.01.2022.
//

import UIKit

final class MainView: UIView {
    lazy var scrollView = makeScrollView()
    lazy var userIDTextField = makeTextField(placeholder: "UserID")
    lazy var setUserIDButton = makeButton(title: "Set UserID")
    lazy var userIDLabel = makeLabel()
    lazy var purchase1Button = makeButton(title: "Buy exam.nursing.lifetime")
    lazy var purchase2Button = makeButton(title: "Buy exam.nursing.monthly")
    lazy var restoreButton = makeButton(title: "Restore purchases")
    lazy var forceSync = makeButton(title: "Force Sync")
    lazy var propertiesTextField = makeTextField(placeholder: "param1, value1. param2, value2.")
    lazy var setPropertiesButton = makeButton(title: "Set Properties")
    lazy var propertiesLabel = makeLabel()
    lazy var getOtterScaleIDButton = makeButton(title: "Get OtterScale ID")
    lazy var getPaymentDataButton = makeButton(title: "Get Payment Data")
    lazy var getSubscriptionsButton = makeButton(title: "Get Subscriptions")
    lazy var getNonConsumablesButton = makeButton(title: "Get Non Consumables")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension MainView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userIDTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userIDTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            userIDTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            userIDTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            userIDTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userIDTextField.heightAnchor.constraint(equalToConstant: 54),
            userIDTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 64)
        ])
        
        NSLayoutConstraint.activate([
            setUserIDButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            setUserIDButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            setUserIDButton.heightAnchor.constraint(equalToConstant: 54),
            setUserIDButton.topAnchor.constraint(equalTo: userIDTextField.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            userIDLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userIDLabel.topAnchor.constraint(equalTo: setUserIDButton.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            purchase1Button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            purchase1Button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            purchase1Button.heightAnchor.constraint(equalToConstant: 54),
            purchase1Button.topAnchor.constraint(equalTo: setUserIDButton.bottomAnchor, constant: 84)
        ])
        
        NSLayoutConstraint.activate([
            purchase2Button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            purchase2Button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            purchase2Button.heightAnchor.constraint(equalToConstant: 54),
            purchase2Button.topAnchor.constraint(equalTo: purchase1Button.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            restoreButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            restoreButton.heightAnchor.constraint(equalToConstant: 54),
            restoreButton.topAnchor.constraint(equalTo: purchase2Button.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            forceSync.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            forceSync.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            forceSync.heightAnchor.constraint(equalToConstant: 54),
            forceSync.topAnchor.constraint(equalTo: restoreButton.bottomAnchor, constant: 64)
        ])
        
        NSLayoutConstraint.activate([
            propertiesTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            propertiesTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            propertiesTextField.heightAnchor.constraint(equalToConstant: 54),
            propertiesTextField.topAnchor.constraint(equalTo: forceSync.bottomAnchor, constant: 64)
        ])
        
        NSLayoutConstraint.activate([
            setPropertiesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            setPropertiesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            setPropertiesButton.heightAnchor.constraint(equalToConstant: 54),
            setPropertiesButton.topAnchor.constraint(equalTo: propertiesTextField.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            propertiesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            propertiesLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            propertiesLabel.topAnchor.constraint(equalTo: setPropertiesButton.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            getOtterScaleIDButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            getOtterScaleIDButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            getOtterScaleIDButton.heightAnchor.constraint(equalToConstant: 54),
            getOtterScaleIDButton.topAnchor.constraint(equalTo: propertiesLabel.bottomAnchor, constant: 64)
        ])
        
        NSLayoutConstraint.activate([
            getPaymentDataButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            getPaymentDataButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            getPaymentDataButton.heightAnchor.constraint(equalToConstant: 54),
            getPaymentDataButton.topAnchor.constraint(equalTo: getOtterScaleIDButton.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            getSubscriptionsButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            getSubscriptionsButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            getSubscriptionsButton.heightAnchor.constraint(equalToConstant: 54),
            getSubscriptionsButton.topAnchor.constraint(equalTo: getPaymentDataButton.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            getNonConsumablesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            getNonConsumablesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            getNonConsumablesButton.heightAnchor.constraint(equalToConstant: 54),
            getNonConsumablesButton.topAnchor.constraint(equalTo: getSubscriptionsButton.bottomAnchor, constant: 12),
            getNonConsumablesButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -64)
        ])
    }
}

// MARK: Lazy initialization
private extension MainView {
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.white
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField(placeholder: String) -> UITextField {
        let view = UITextField()
        view.placeholder = placeholder
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeButton(title: String) -> UIButton {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        view.layer.borderWidth = 2
        view.setTitleColor(UIColor.gray, for: .normal)
        view.setTitle(title, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeLabel(text: String? = nil) -> UILabel {
        let view = UILabel()
        view.text = text
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
}
