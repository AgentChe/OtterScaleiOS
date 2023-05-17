//
//  AnalyticsDelegate.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 17.05.2023.
//

public protocol AnalyticsDelegate: AnyObject {
    func analyticsDidReceive(attributionsModel: ADServiceAttributionsModel?)
}
