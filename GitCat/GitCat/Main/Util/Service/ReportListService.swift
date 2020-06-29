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
    
    //MARK: GET - https://a.gitcat.app/api/report/repoList (월간 레포트의 목록을 불러오는 API)
    

    func getReportList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let reportListURL = self.url("/report/list")

        gettable(ReportListModel(),reportListURL) { (result) in
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
