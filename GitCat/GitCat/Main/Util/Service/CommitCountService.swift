//
//  CommitService.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
struct CommitCountService: GettableService, APIServie {
     
    typealias NetworkData = CommitCountModel
    static let sharedInstance = CommitCountService()
    
    //MARK: GET - https://a.chameleon4switch.cf/calender/monthCommitCount?email=\(email)&month=\(month) (해당 달의 커밋달력 잔디 색 레벨 값 반환 API)
    

    func getCommit(month:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let commitURL = self.url("/calender/commit-count?date=\(month)")

        gettable(CommitCountModel(),commitURL) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.getSuccess.rawValue:
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.accessDenied.rawValue: //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.maintainance.rawValue: //419
                    completion(.maintainance)
                    break
                case HttpResponseCode.serverErr.rawValue:
                    completion(.serverErr)
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
                break
            case .noContents:
                break
            }
        }
    }
}
