//
//  APIEnvironment.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 11.01.2022.
//

protocol APIEnvironmentProtocol {
    var host: String { get }
}

struct APIEnvironment: APIEnvironmentProtocol {
    var host: String {
        "https://api.otterscale.com"
    }
}
