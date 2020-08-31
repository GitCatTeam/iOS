//
//  StringExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
import CryptoSwift

let keyData = Secrets.PrivatekeyData
let ivData = Secrets.PrivateivData

extension String {
    func aesDecrypt() throws -> String {
        
        let encryptedData: NSData = self.hexStringToData()
        let decrypted = try AES(key: keyData, iv: ivData, padding: .pkcs7).decrypt([UInt8](encryptedData))

        return String(bytes: decrypted, encoding: .utf8)!
    }

    func hexStringToData() -> NSData {
        let data = NSMutableData()
        var temp = ""
        for char in self {
            temp += String(char)
            if temp.count == 2 {
                let scanner = Scanner(string: temp)
                var value: CUnsignedInt = 0
                scanner.scanHexInt32(&value)
                data.append(&value, length: 1)
                temp = ""
            }
        }
        return data as NSData
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment:  "")
    }
}
