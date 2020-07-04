//
//  DeleteTokenService.swift
//  GitCat
//
//  Created by 조윤영 on 28/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

struct DeleteTokenService: DelettableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = DeleteTokenService()
    
    //MARK: Delete - https://a.gitcat.app/api/notification/device-token (토큰 삭제 API)

    func deleteToken(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let deleteURL = self.url("/notification/device-token")
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let params : [String : Any] = ["deviceId" : uuid ?? "" ]
        
        delete(deleteURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.maintainance.rawValue: //503
                    completion(.maintainance)
                    break
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.serverErr.rawValue.description : //500
                    completion(.serverErr)
                    break
                default :
                    print("Error: \(resCode)")
                    break
                }
                break
                
            case .failure(_):
                completion(.networkFail)
                print("Fail: Network Fail")
                break
            case .noContents:
                break
            }
        }
        
    }
}
