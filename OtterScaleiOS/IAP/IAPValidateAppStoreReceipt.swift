//
//  IAPValidateAppStoreReceipt.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 15.01.2022.
//

protocol IAPValidateAppStoreReceiptProtocol {
    func validate(appStoreReceipt: String,
                  prices: [IAPPrice],
                  completion: ((AppStoreValidateResult?) -> Void)?)
}

final class IAPValidateAppStoreReceipt: IAPValidateAppStoreReceiptProtocol {
    deinit {
        operation = nil
    }
    
    private var operation: APIOperation?
    private lazy var operationWrapper = APIOperationWrapper()
    
    private let storage: StorageProtocol
    private let requestDispatcher: RequestDispatcherProtocol
    private let apiEnvironment: APIEnvironmentProtocol
    private let mapper: ValidateAppStoreReceiptResponseProtocol
    private let appStoreReceiptSource: AppStoreReceiptSourceProtocol
    private let paymentDataBuilder: PaymentDataBuilderProtocol
    
    init(storage: StorageProtocol,
         requestDispatcher: RequestDispatcherProtocol,
         apiEnvironment: APIEnvironmentProtocol,
         mapper: ValidateAppStoreReceiptResponseProtocol = ValidateAppStoreReceiptResponse(),
         appStoreReceiptSource: AppStoreReceiptSourceProtocol = AppStoreReceiptSource(),
         paymentDataBuilder: PaymentDataBuilderProtocol = PaymentDataBuilder()) {
        self.storage = storage
        self.requestDispatcher = requestDispatcher
        self.apiEnvironment = apiEnvironment
        self.mapper = mapper
        self.appStoreReceiptSource = appStoreReceiptSource
        self.paymentDataBuilder = paymentDataBuilder
    }
}

// MARK: Internal
extension IAPValidateAppStoreReceipt {
    func validate(appStoreReceipt: String,
                  prices: [IAPPrice] = [],
                  completion: ((AppStoreValidateResult?) -> Void)?) {
        let request = ValidateAppStoreReceiptRequest(apiKey: apiEnvironment.apiKey,
                                                     anonymousID: storage.anonymousID,
                                                     externalUserID: storage.externalUserID,
                                                     internalUserID: storage.internalUserID,
                                                     appStoreReceipt: appStoreReceipt,
                                                     prices: prices)
        
        operation = APIOperation(endPoint: request)
        
        operationWrapper.execute(operation: operation!, dispatcher: requestDispatcher) { [weak self] result in
            guard let self = self else {
                return
            }
            
            guard
                let response = result,
                let appStoreValidateResult = self.mapper.map(response: response)
            else {
                let result = self.tryLocalParseReceipt()
                completion?(result)
                
                return
            }
            
            completion?(appStoreValidateResult)
            
            self.operation = nil
        }
    }
    
    func tryLocalParseReceipt() -> AppStoreValidateResult? {
        guard let receipt = appStoreReceiptSource.appStoreReceipt(parser: AppStoreReceiptParser()) else {
            return nil
        }
        
        let paymentData = paymentDataBuilder.build(purchases: receipt.inAppPurchases)
        
        let result = merge(paymentData: paymentData,
                           cached: storage.paymentData,
                           userId: storage.userId,
                           internalUserID: storage.internalUserID,
                           externalUserID: storage.externalUserID,
                           usedProducts: storage.usedProducts ?? UsedProducts(appleAppStore: [],
                                                                              googlePlay: [],
                                                                              stripe: []),
                           userSince: storage.userSince,
                           accessValidTill: storage.accessValidTill)
        
        return result
    }
    
    func merge(paymentData: PaymentData,
               cached: PaymentData?,
               userId: Int?,
               internalUserID: String?,
               externalUserID: String?,
               usedProducts: UsedProducts,
               userSince: String?,
               accessValidTill: String?) -> AppStoreValidateResult {
        let subscriptions = SubscriptionsPaymentData(appleAppStore: paymentData.subscriptions.appleAppStore,
                                                     googlePlay: cached?.subscriptions.googlePlay ?? [],
                                                     stripe: cached?.subscriptions.stripe ?? [],
                                                     paypal: cached?.subscriptions.paypal ?? [])
        let nonConsumables = NonConsumablesPaymentData(appleAppStore: paymentData.nonConsumables.appleAppStore,
                                                       googlePlay: cached?.nonConsumables.googlePlay ?? [],
                                                       stripe: cached?.nonConsumables.googlePlay ?? [],
                                                       paypal: cached?.nonConsumables.paypal ?? [])
        
        let data = PaymentData(subscriptions: subscriptions,
                               nonConsumables: nonConsumables)
        
        return AppStoreValidateResult(userId: userId,
                                      internalUserID: internalUserID,
                                      externalUserID: externalUserID,
                                      paymentData: data,
                                      usedProducts: usedProducts,
                                      userSince: userSince,
                                      accessValidTill: accessValidTill)
    }
}
