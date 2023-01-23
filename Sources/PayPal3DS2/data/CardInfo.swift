//
//  File.swift
//  
//
//  Created by YOSEPH TILAHUN on 1/22/23.
//

import Foundation

public enum ResponseStatus {
    case cardNotSetup
    case threeDS2Verified
    case threeDS2NotRequired
    case threeDS2BankVerification
    case threeDS2failed
    case threeDS2UnKnown
}

extension ResponseStatus {
   public var statusMessage: String {
        switch self {
        case .cardNotSetup:
            return "3DS2 is not configured for this card."
        case .threeDS2Verified:
            return "3DS2 is verified  by the issuer for this card."
        case .threeDS2NotRequired:
            return "3DS2 verification is not required."
        case .threeDS2BankVerification:
            return "3DS2 Issuing back app verification required."
        case .threeDS2failed:
            return "3DS2 verification failed."
        case .threeDS2UnKnown:
            return "3DS2 status Unknown."
        }
    }
}

public struct CardInfo {
    public var id: String
    public var name: String
    public var type: String
    public var cardNumber: String
    public var threeDS2: String
    public var cvv: String
    public var postalCode: String
    public var expirationDate: String
    public var responseStatus: ResponseStatus
    
    public init (id: String, name: String, type: String, cardNumber: String, threeDS2: String, cvv: String, postalCode: String, expirationDate: String, responseStatus: ResponseStatus = ResponseStatus.threeDS2UnKnown) {
        self.id = id
        self.name = name
        self.type = type
        self.cardNumber = cardNumber
        self.threeDS2 = threeDS2
        self.cvv = cvv
        self.postalCode = postalCode
        self.expirationDate = expirationDate
        self.responseStatus = responseStatus
    }
}


    
