//
//  CertificateUtility.swift
//  PayPal3dS2
//
//  Created by Yoseph Tilahun on 3/2/23.
//

import Foundation
import SwiftUI

/// Generic Begin Marker
let GENERIC_BEGIN_MARKER: String                = "-----BEGIN"

/// Generic End Marker
let GENERIC_END_MARKER: String                = "-----END"

let GENERIC_SDS2_DATA_To_ENCRYPT: String                = "3DS2-Data-5679"



class CertificateService {

    @ObservedObject var certificateDataVM: CertificateDataVM = .shared
    
    func downLoadCertificate(request: URLRequest, delegate: URLSessionDelegate) {
        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue:OperationQueue.main)

        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            if error == nil {
                let result = NSString(data: data!, encoding:
                                        String.Encoding.ascii.rawValue)!

                let resultStr = result as String
                self.certificateDataVM.updateCertificatePayLoad(value: resultStr)
                //print(result)

            } else {
                print(error.debugDescription)
            }
        }
        task.resume()
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }

    func getCertificateExpirationDate(data: Data, name: String) -> (notValidBefore:String, notValidAfter:String) {
        guard let decodedString = String( data: data, encoding: .ascii ) else { return ("", "") }
        var foundWWDRCA         = false
        var notValidBeforeDate  = ""
        var notValidAfterDate   = ""
        
        decodedString.enumerateLines { (line, _) in
            if foundWWDRCA && (notValidBeforeDate.isEmpty || notValidAfterDate.isEmpty) {
                let certificateData = line.prefix(13)
                if notValidBeforeDate.isEmpty && !certificateData.isEmpty {
                    notValidBeforeDate = String(certificateData)
                    self.certificateDataVM.updateValidBeforeDate(value: notValidBeforeDate)
                    print(notValidBeforeDate)
                } else if notValidAfterDate.isEmpty && !certificateData.isEmpty {
                    notValidAfterDate = String(certificateData)
                    self.certificateDataVM.updateValidAfterDate(value: notValidAfterDate)
                    print(notValidAfterDate)
                }
            }
            
            if line.contains(name) { foundWWDRCA = true }
        }
        return (notValidBeforeDate, notValidAfterDate)
        
    }

    func getCertificateData(payload: String) -> Data {
         var payloadTrimmed = payload.trimmingCharacters(in: .whitespacesAndNewlines)

        payloadTrimmed = payloadTrimmed.replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
        payloadTrimmed = payloadTrimmed.replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")

         var lines = payloadTrimmed.components(separatedBy: "\n").filter { line in
            return !line.hasPrefix(GENERIC_BEGIN_MARKER) && !line.hasPrefix(GENERIC_END_MARKER)
        }

        // No lines, no data...
        guard lines.count != 0 else {
          return Data()
        }
        lines = lines.map { $0.replacingOccurrences(of: "\r", with: "") }

        let value = lines.joined(separator: "")
        return Data(base64Encoded: value)!
    }

    func getPublicKey(data: Data) -> SecKey? {
        var key: SecKey? = nil

        let certificateData = SecCertificateCreateWithData(nil, data as CFData)
        guard let certData = certificateData else {
          return key
        }

        let copyKey: (SecCertificate) -> SecKey?

        if #available(iOS 12.0, watchOS 5.0, *) {
            copyKey = SecCertificateCopyKey
        } else {
            copyKey = SecCertificateCopyPublicKey
        }
        key = copyKey(certData)
        return key

    }

    func encryptPayLoad(payload: String, key: SecKey) -> String? {
        let buffer = [UInt8](payload.utf8)
        var keySize = SecKeyGetBlockSize(key)
        var keyBuffer = [UInt8](repeating: 0, count: keySize)

        // Encrypto should less than key length
        guard SecKeyEncrypt(key, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else { return nil }
        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
    }
}
