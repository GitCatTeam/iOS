//
//  HomeService.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


import Foundation
struct HomeService: GettableService, APIService {
     
    typealias NetworkData = HomeModel
    static let sharedInstance = HomeService()
    
    //MARK: GET - https://a.gitcat.app/api/home/main (업데이트된 홈 데이터를 불러오는 API)
    

    func getHomeData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let homeURL = self.url("/home/main")

        gettable(HomeModel(),homeURL) { (result) in
            switch result {
            
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue:
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue: //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue:
                    completion(.duplicated)
                    break
                case HttpResponseCode.maintainance.rawValue: //503
                    completion(.maintainance)
                    break
                case HttpResponseCode.needData.rawValue:
                    completion(.dataNeeded)
                default:
                    print("SUCCESS: \(networkResult.resCode)")
                    break
                }
                break
            case .error(let resCode):
                switch resCode {
                case HttpResponseCode.accessDenied.rawValue.description:
                    completion(.accessDenied)
                    break
                case HttpResponseCode.serverErr.rawValue.description:
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
            case .noContents:
                break
            }
        }
    }
}
