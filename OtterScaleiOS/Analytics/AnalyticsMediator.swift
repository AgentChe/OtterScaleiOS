//
//  AnalyticsMediator.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 17.05.2023.
//

protocol AnalyticsMediatorProtocol {
    func notifyAbout(model: ADServiceAttributionsModel?)
    func add(delegate: AnalyticsDelegate)
    func remove(delegate: AnalyticsDelegate)
}

final class AnalyticsMediator: AnalyticsMediatorProtocol {
    static let shared = AnalyticsMediator()
    
    private var delegates = [Weak<AnalyticsDelegate>]()
    
    private init() {}
    
    func notifyAbout(model: ADServiceAttributionsModel?) {
        delegates.forEach { $0.weak?.analyticsDidReceive(attributionsModel: model) }
    }
    
    func add(delegate: AnalyticsDelegate) {
        let weakly = delegate as AnyObject
        delegates.append(Weak<AnalyticsDelegate>(weakly))
        delegates = delegates.filter { $0.weak != nil }
    }
    
    func remove(delegate: AnalyticsDelegate) {
        if let index = delegates.firstIndex(where: { $0.weak === delegate }) {
            delegates.remove(at: index)
        }
    }
}
