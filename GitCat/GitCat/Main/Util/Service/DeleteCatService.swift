//
//  DeleteCatService.swift
//  GitCat
//
//  Created by 조윤영 on 30/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


struct DeleteCatService: DelettableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = DeleteCatService()
    
    //MARK: Delete - https://a.gitcat.app/api/home/cats (고양씨 초기화 API)
    func deleteCat(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let deleteURL = self.url("/home/cats")
        
        delete(deleteURL, params: [:]) { (result) in
            switch result {
            
            
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.needData.rawValue : //204
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
                completion(.dataNeeded)
                break
            }
        }
        
    }
}
