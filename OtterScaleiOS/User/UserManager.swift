//
//  UserManager.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 16.01.2022.
//

protocol UserManagerProtocol {
    func set(userID: String,
             mapper: UserSetResponseProtocol,
             completion: ((Bool) -> Void)?)
}

final class UserManager: UserManagerProtocol {
    private let apiEnvironment: APIEnvironmentProtocol
    private let storage: StorageProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    
    private lazy var operations = [String: APIOperation]()
    
    init(apiEnvironment: APIEnvironmentProtocol,
         storage: StorageProtocol) {
        self.apiEnvironment = apiEnvironment
        self.storage = storage
        self.requestDispatcher = RequestDispatcher(environment: apiEnvironment,
                                                  networkSession: NetworkSession())
    }
}

// MARK: Internal
extension UserManager {
    func set(userID: String,
             mapper: UserSetResponseProtocol = UserSetResponse(),
             completion: ((Bool) -> Void)?) {
        let userParameters = [
            "external_id": userID
        ]
        let request = UserSetRequest(apiKey: apiEnvironment.apiKey,
                                     anonymousID: storage.anonymousID,
                                     externalUserID: storage.externalUserID,
                                     otterScaleUserID: storage.otterScaleUserID,
                                     userParameters: userParameters)
        let operation = APIOperation(endPoint: request)
        
        let key = "set_user_id"
        
        operations[key] = operation
        
        operation.execute(dispatcher: requestDispatcher) { [weak self] response in
            if let response = response {
                let result = mapper.map(response: response)
                completion?(result)
            } else {
                completion?(false)
            }
            
            self?.operations.removeValue(forKey: key)
        }
    }
}
