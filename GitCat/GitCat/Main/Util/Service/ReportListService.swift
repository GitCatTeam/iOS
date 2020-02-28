//
//  ReportListService.swift
//  GitCat
//
//  Created by 조윤영 on 19/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
struct ReportListService: GettableService, APIServie {
     
    typealias NetworkData = ReportListModel
    static let sharedInstance = ReportListService()
    
    //MARK: GET - https://a.gitcat.app/api/monthly/repoList (월간 레포트의 목록을 불러오는 API)
    

    func getReportList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let reportListURL = self.url("/monthly/list")

        gettable(reportListURL) { (result) in
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
