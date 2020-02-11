//
//  AuthService.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct AuthService: GettableService, APIServie {

    typealias NetworkData = SignInCodeData
    static let sharedInstance = AuthService()
    
    //MARK: GET - https://a.gitcat.app/api/auth/github (Github 로그인을 통한 Personal Access Token 교환 코드 발급
    
    func getUserEmail(completion: @escaping (NetworkResult<Any>) -> Void) {
        let signInURL = self.url("/auth/github")
        
        gettable(signInURL) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue:
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.serverErr.rawValue:
                    completion(.serverErr)
                default:
                    print("SUCCESS: \(networkResult.resCode)")
                    break
                    
                }
                break
                
            case .error(let resCode):
                switch resCode {
                case HttpResponseCode.badRequest.rawValue.description:
                    completion(.badRequest)
                    
                case HttpResponseCode.conflict.rawValue.description:
                    completion(.duplicated)
                    
                default:
                    print("ERROR: \(resCode)")
                    break
                }
                break
                
            case .failure(_) :
                completion(.networkFail)
                print("FAIL: Network Fail")
            }
    
        }
        
    }
}
