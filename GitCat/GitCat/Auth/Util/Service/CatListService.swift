//
//  CatListService.swift
//  GitCat
//
//  Created by 조윤영 on 27/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

struct CatListService: GettableService, APIService {
     
    typealias NetworkData = CatListModel
    static let sharedInstance = CatListService()
    
    //MARK: GET - https://a.gitcat.app/api/home/cats (선택할 수 있는 고양이 가져오기)
    
    func getCatList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let catListURL = self.url("/home/cats")

        gettable(CatListModel(),catListURL) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue: //400
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue://409
                    completion(.duplicated)
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
                case HttpResponseCode.accessDenied.rawValue.description: //401
                    completion(.accessDenied)
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
