//
//  ReportDetailService.swift
//  GitCat
//
//  Created by 조윤영 on 19/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
struct ReportDetailService: GettableService, APIService {
     
    typealias NetworkData = ReportDetailModel
    static let sharedInstance = ReportDetailService()
    
    //MARK: GET - https://a.gitcat.app/api/monthly/repoDetail?id=1 (월간 레포트의 상세 데이터를 불러오는 API)

    func getReportDetail(id:Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let reportDetailURL = self.url("/report/detail?id=\(id)")

        gettable(ReportDetailModel(),reportDetailURL) { (result) in
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
                case HttpResponseCode.serverErr.rawValue.description : //500
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
