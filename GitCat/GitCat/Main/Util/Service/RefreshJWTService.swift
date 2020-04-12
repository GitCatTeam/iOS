//
//  RefreshJWTService.swift
//  GitCat
//
//  Created by 조윤영 on 11/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import Alamofire




struct RefreshJWTService: RefreshGettableService, APIServie {

     
    typealias NetworkData = RefreshTokenModel
    static let sharedInstance = RefreshJWTService()
    
    //MARK: GET - https://a.gitcat.app/api/auth/refresh-token (토큰 리프레쉬 API)
    
   
    
    func getRefreshToken(headers:HTTPHeaders,completion: @escaping (NetworkResult<Any>) -> Void) {
        let refreshURL = self.url("/auth/refresh-token")

        ref_gettable(RefreshTokenModel(),refreshURL,headers) { (result) in
            switch result {
            case .success(let networkResult):
                
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.serverErr.rawValue: //500
                    completion(.serverErr)
                    break
                case HttpResponseCode.accessDenied.rawValue: //401
                    completion(.accessDenied)
                    break
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
                
            case .failure(_):
                completion(.networkFail)
                print("FAIL: Network Fail")
                break
            case .noContents:
                break
            }
        }
    }
}
