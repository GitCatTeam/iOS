//
//  PutAdditionalInfoService.swift
//  GitCat
//
//  Created by 조윤영 on 28/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


struct PutAdditionalInfoService: PuttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PutAdditionalInfoService()
    
    //MARK: PUT - https://a.gitcat.app/api/auth/additional (부가정보 서버롤 보내기)
    func putAdditionalInfo(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let modURL = self.url("/auth/additional")
        
        put(modURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
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
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue.description : //409
                    completion(.duplicated)
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
            case .noContents:
                break
            }
        }
        
    }
}
