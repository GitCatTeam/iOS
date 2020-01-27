//
//  CommitListService.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
struct CommitListService: GettableService, APIServie {
    
    typealias NetworkData = CommitListModel
    static let sharedInstance = CommitListService()
    
    //MARK: GET - https://a.chameleon4switch.cf/calender/monthCommitCount?email=\(email)&day=\(day) (해당 날짜의 커밋 내역 리스트 반환)
    
    func getCommit(email:String, day:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let commitURL = self.url("/api/calender/monthCommitCount?email=\(email)&day=\(day)")
        gettable(commitURL) { (result) in
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
