//
//  CatListService.swift
//  GitCat
//
//  Created by 조윤영 on 27/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

struct CatListService: GettableService, APIServie {
     
    typealias NetworkData = CatListModel
    static let sharedInstance = CatListService()
    
    //MARK: GET - https://a.gitcat.app/api/home/cats (선택할 수 있는 고양이 가져오기)
    
    func getCatList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let catListURL = self.url("/home/cats")

        gettable(catListURL) { (result) in
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
                
            case .failure(_):
                completion(.networkFail)
                print("FAIL: Network Fail")
            }
        }
    }
}
