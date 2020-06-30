//
//  DeleteUserInfo.swift
//  GitCat
//
//  Created by 조윤영 on 08/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct DeleteUserInfo: DelettableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = DeleteUserInfo()
    
    //MARK: Delete - https://a.gitcat.app/api/auth/withdraw (회원 탈퇴 API)
    func withdrawal(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let deleteURL = self.url("/auth/withdraw")
        
        delete(deleteURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.maintainance.rawValue: //419
                    completion(.maintainance(networkResult.resResult))
                    break
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
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
