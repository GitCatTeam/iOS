//
//  CatCollectionService.swift
//  GitCat
//
//  Created by 조윤영 on 13/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
struct CatCollectionService: GettableService, APIServie {
    
    typealias NetworkData = CatCollectionModel
    static let sharedInstance = CatCollectionService()
    
    //MARK: GET - https://a.gitcat.app/api/collection/list (냥컬렉션 리스트 가져오기 API)
    
    func getGraduateCats(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let catCollectionURL = self.url("/collection/list")
        
        gettable(CatCollectionModel(),catCollectionURL) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.maintainance.rawValue: //503
                    completion(.maintainance)
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
                    break
                case HttpResponseCode.accessDenied.rawValue.description: //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue.description:
                    completion(.duplicated)
                    break
                case HttpResponseCode.serverErr.rawValue.description: //500
                    completion(.serverErr)
                    break
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
