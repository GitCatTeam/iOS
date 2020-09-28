//
//  PostCalendarReloadService.swift
//  GitCat
//
//  Created by 조윤영 on 2020/09/28.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
struct PostCalendarReloadService: PosttableService, APIService {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PostCalendarReloadService()
    
    //MARK: POST - https://a.gitcat.app/api/v1/calender/commit (커밋 달력 새로고침 API)
    
    func postCalendarReload(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let calendarReloadURL = self.url("/calender/commit?date=\(date)")
        
        //커밋 데이터 업데이트
        post(calendarReloadURL, params: [:]) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue: //401
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
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
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
                break
            case .noContents:
                break
            }
        }
        
    }
}
