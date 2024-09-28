//
//  String+Extension.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import Foundation
import CryptoSwift

extension String{
    
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,9}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func aesEncrypt() throws -> String{
        let data = self.data (using: .utf8)!
        let encrypted = try! AES(key: Array("1234567890123456".utf8), blockMode:
                                    CBC.init(iv: Array("1234567890123456".utf8)), padding:
                .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data (encrypted)
        return encryptedData.base64EncodedString ()
    }
    
    func aesDecrypt() throws -> String{
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: Array("1234567890123456".utf8), blockMode:
                                    CBC.init(iv: Array("1234567890123456".utf8)), padding:
                .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data (decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8)
        ?? "default"
    }
}
