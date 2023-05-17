//
//  SendADServiceTokenResponse.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 17.05.2023.
//

protocol SendADServiceTokenResponseProtocol {
    func map(response: Any) -> ADServiceAttributionsModel?
}

final class SendADServiceTokenResponse: SendADServiceTokenResponseProtocol {
    func map(response: Any) -> ADServiceAttributionsModel? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let hasAttribution = data["has_attribution"] as? Bool
        else {
            return nil
        }
        
        return ADServiceAttributionsModel(
            hasAttribution: hasAttribution,
            channel: data["channel"] as? String,
            campaign: data["campaign"] as? String,
            adgroup: data["adgroup"] as? String,
            feature: data["feature"] as? String
        )
    }
}
