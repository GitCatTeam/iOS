//
//  CommitListService.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
struct CommitListService: GettableService, APIService {
    
    typealias NetworkData = CommitListModel
    static let sharedInstance = CommitListService()
    
    //MARK: GET - https://a.gitcat.app/api/calender/commit?date=\(date) (해당 날짜의 커밋 내역 리스트 반환 API)
    
    func getCommitData(date:String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let commitURL = self.url("/calender/commit?date=\(date)")
        
        gettable(CommitListModel(),commitURL) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.getSuccess.rawValue:
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.badRequest.rawValue:
                    completion(.badRequest)
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.conflict.rawValue:
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
                break
            case .noContents:
                break
            }
        }
    }
}
