//
//  DeleteTokenService.swift
//  GitCat
//
//  Created by 조윤영 on 28/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct DeleteTokenService: DelettableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = DeleteTokenService()
    
    //MARK: Delete - https://a.gitcat.app/api/notification/device-token (댓글 삭제)
    func deleteToken(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let deleteURL = self.url("/notification/device-token")
        
        delete(deleteURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))

                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
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
