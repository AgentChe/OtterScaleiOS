//
//  ReceiptReadingError.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 01.02.2022.
//

import Foundation

enum ReceiptReadingError: Error, Equatable {
    case missingReceipt,
         emptyReceipt,
         dataObjectIdentifierMissing,
         asn1ParsingError,
         receiptParsingError,
         inAppPurchaseParsingError
}
