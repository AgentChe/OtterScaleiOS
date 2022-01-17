//
//  ViewController.swift
//  OtterScaleiOSExamples
//
//  Created by Андрей Чернышев on 10.01.2022.
//

import UIKit
import OtterScaleiOS

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        OtterScale.shared.initialize(host: "https://api.otterscale.com", apiKey: "oCrVwRgejQISV560")
        
        OtterScale.shared.set(userID: "456")
    }
}
