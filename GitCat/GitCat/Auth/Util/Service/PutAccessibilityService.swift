//
//  PutAccessibilityService.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/29.
//  Copyright © 2020 조윤영. All rights reserved.
//

struct PutAccessibilityService: PuttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PutAccessibilityService()
    
    //MARK: PUT - https://a.gitcat.app/api/auth/scope (부가정보 서버롤 보내기)
    func putAccessibility(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let modURL = self.url("/auth/scope")
        
        put(modURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue : //409
                    completion(.duplicated)
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
                    
                case HttpResponseCode.badRequest.rawValue.description :
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue.description :
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue.description : //409
                    completion(.duplicated)
                    break
                default :
                    print("Error: \(resCode)")
                    break
                }
                break
                
            case .failure(_):
                completion(.networkFail)
                print("Fail: Network Fail")
            case .noContents:
                break
            }
        }
        
    }
}
