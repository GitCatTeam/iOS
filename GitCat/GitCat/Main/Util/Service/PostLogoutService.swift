//
//  PostLogoutService.swift
//  GitCat
//
//  Created by 조윤영 on 04/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct PostLogoutService: PosttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PostLogoutService()
    
    //MARK: POST - https://a.gitcat.app/api/auth/logout (로그아웃 API)
    
    func postLogout(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let userDataURL = self.url("/auth/logout")
        
        post(userDataURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
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
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    break
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
