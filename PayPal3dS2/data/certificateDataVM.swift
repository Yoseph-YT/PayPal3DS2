//
//  certificateDataVM.swift
//  PayPal3dS2
//
//  Created by Yoseph Tilahun on 3/2/23.
//

import Foundation

class CertificateDataVM: ObservableObject {

    private init() { }
    static let shared = CertificateDataVM()
    @Published var certificateExpired = false
    @Published var validBeforeDate = ""
    @Published var validAfterDate = ""
    @Published var certificatePayload = ""
    @Published var publicKey = ""

    func updateCertificatePayLoad(value: String) {
        certificatePayload =  value
    }

    func updateValidBeforeDate(value: String) {
        validBeforeDate =  value
    }

    func updateValidAfterDate(value: String) {
        validAfterDate =  value
    }
}
