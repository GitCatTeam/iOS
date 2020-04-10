//
//  PostUserDataService.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import JWTDecode

struct PostUserDataService: PosttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PostUserDataService()
    
    //MARK: POST - https://a.gitcat.app/api/home/commits (로딩과정에서 사용자의 Github 커밋 데이터 불러오기 API)
    
    func postUserData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let userDataURL = self.url("/home/commits")
        
        //만약 토큰이 만료되었다면 갱신
        do {
            let jwt = try decode(jwt: UserDefaults.standard.string(forKey: "token")!)
            print("========================this is token!!!=============================")
            print(jwt)
            print("========================this is token!!!=============================")
            
            
            print(jwt.issuedAt)
            print(jwt.expiresAt)
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
        }
        
        
        
        //커밋 데이터 업데이트
        post(userDataURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
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
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    
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
