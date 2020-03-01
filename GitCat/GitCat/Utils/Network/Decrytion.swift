//
//  Decrytion.swift
//  GitCat
//
//  Created by 조윤영 on 28/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import Security
import CommonCrypto
import CryptoSwift
protocol Decrytion {
    
}
extension Decrytion {
    static func decryptArtisan(cryptedMessage: String , key:String) -> String? {
        var clairMessage:String? = nil;
        
        if let cryptedData = Data(base64Encoded: cryptedMessage) {
            do {
                let aes = try AES(key: Array<UInt8>(key.utf8), blockMode: ECB(), padding: .pkcs5) // aes128
                let cipher = try aes.decrypt(Array<UInt8>(cryptedData))
                clairMessage = String(bytes: cipher, encoding: .utf8)
            }catch{
                let error = error as NSError
                print(error)
            }
        }
        
        return clairMessage
    }
}
//extension String {
//
//    func aesEncrypt(key: String, iv: String) throws -> String{
//
//        let data = self.data(usingEncoding: String.Encoding.utf8)
//
//        let enc = try AES(key: key, iv: iv, blockMode:.ECB, padding: PKCS7()).encrypt(data!.arrayOfBytes())
//
//        let encData = NSData(bytes: enc, length: Int(enc.count))
//
//        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
//
//        let result = String(base64String)
//
//        return result
//
//    }
//
//    
//
//    func aesDecrypt(key: String, iv: String) throws -> String {
//
//        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
//
//        let dec = try AES(key: key, iv: iv, blockMode: .ECB, padding: PKCS7()).decrypt(data!.arrayOfBytes())
//
//        let decData = NSData(bytes: dec, length: Int(dec.count))
//
//        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
//
//        return String(result!)
//
//    }
//
//}



//func decrypt(data:Data , keyData:Data, ivData:Data) -> Data? {
//        let keyLength = keyData.count
//        let dataLength = data.count
//
//        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
//        if (validKeyLengths.contains(keyLength) == false) {
//            print("Invalid key length")
//            return nil;
//        }
//
//        let clearLength = size_t(data.count)
//        var clearData = Data(count:clearLength)
//
//        var numBytesDecrypted :size_t = 0
//        let options   = CCOptions(kCCOptionPKCS7Padding)
//
//
//        let cryptStatus = clearData.withUnsafeMutableBytes {cryptBytes in
//            data.withUnsafeBytes {dataBytes in
//                ivData.withUnsafeBytes {ivBytes in
//                    keyData.withUnsafeBytes {keyBytes in
//                        CCCrypt(CCOperation(kCCDecrypt),
//                                CCAlgorithm(kCCAlgorithmAES128),
//                                options,
//
//                                keyBytes, //key bytes
//                                keyLength, //key length
//
//                                ivBytes, //iv bytes
//                                dataBytes, //iv bytes
//
//                                dataLength,
//
//                                cryptBytes,
//                                clearLength,
//                                &numBytesDecrypted)
//                    }
//                }
//            }
//        }
//
//        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
//            clearData.count = numBytesDecrypted
//        }
//        else {
//            print("decrypt failed")
//            return nil;
////            throw AESError.CryptorError(("Decryption failed", Int(cryptStatus)))
//        }
//
//        return clearData;
//    }



//12:25 시도
//extension String {
//    func aesDecrypt(key: String, iv: String) -> String {
//        let data = Data(base64Encoded: self)!
//        do{
//            let decrypted = try! AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7).decrypt([UInt8](data))
//            let decryptedData = Data(decrypted)
//            return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
//        }
//        catch {
//            print("error in aes")
//        }
//    }
//}
//extension String{
//    func aesEncrypt(key: String) throws -> String {
//
//        // Encryption
//        let data = self.data(using: .utf8)!
//        let password = key
//        let ciphertext = RNCryptor.encrypt(data: data, withPassword: password)
//        let encryptedData = Data(ciphertext)
//        let stringEncrypt: String = encryptedData.base64EncodedString()
//        print("encryptedData: \(stringEncrypt)")
//        return stringEncrypt
//    }
//
//    func aesDecrypt(key: String) throws -> String {
//
//        // Decryption
//        let data = Data(base64Encoded: self)!
//        let password = key
//
//        do {
//            let ciphertext = try RNCryptor.decrypt(data: data, withPassword: password)
//            let decryptedData = Data(ciphertext)
//            let stringDecrypt = String(bytes: decryptedData, encoding: .utf8) ?? "Could not decrypt"
//            print("decryptedData: \(stringDecrypt)")
//            return stringDecrypt
//
//        } catch {
//            print(error)
//            return "Error"
//        }
//    }
//}

//
//func dataToByteArray(data: NSData) -> [UInt8] {
//    let pointer = data.bytes.assumingMemoryBound(to: UInt8.self)
//
//    let buffer = UnsafeBufferPointer(start: pointer, count: data.length)
//
//    return Array<UInt8>(buffer)
//}



