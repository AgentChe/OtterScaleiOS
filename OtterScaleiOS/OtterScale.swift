//
//  OtterScale.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 10.01.2022.
//

public final class OtterScale {
    static let shared = OtterScale()
    
    private lazy var storage: StorageProtocol = Storage()
    private lazy var launches: NumberLaunchesProtocol = NumberLaunches()
    
    private var apiEnvironment: APIEnvironmentProtocol!
}

// MARK: Public
public extension OtterScale {
    func initialize(host: String, apiKey: String) {
        launches.launch()
        
        apiEnvironment = APIEnvironment(host: host, apiKey: apiKey)
    }
}
