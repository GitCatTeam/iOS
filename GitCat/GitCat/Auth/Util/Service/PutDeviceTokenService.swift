//
//  PutDeviceTokenService.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/30.
//  Copyright © 2020 조윤영. All rights reserved.
//

struct PutDeviceTokenService: PuttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PutDeviceTokenService()
    
    //MARK: PUT - https://a.gitcat.app/api/notification/device-token (DeviceToken 서버로 보내기)
    func putDeviceToken(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
         let deviceTokenURL = self.url("/notification/device-token")
               
        put(deviceTokenURL, params: params) { (result) in
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
            case .noContents:
                break
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.badRequest.rawValue.description :
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue.description :
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue.description :
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
            }
        }
        
    }
}

