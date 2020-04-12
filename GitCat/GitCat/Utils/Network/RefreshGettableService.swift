//
//  RefreshGettableService.swift
//  GitCat
//
//  Created by 조윤영 on 11/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol RefreshGettableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func ref_gettable(_ model:Codable,_ URL: String,  _ getRefreshHeaders:HTTPHeaders,method: HTTPMethod, completion: @escaping (Result<networkResult>) -> Void)
    
}




extension RefreshGettableService {
    
    func gino(_ value : Int?) -> Int {
           return value ?? 0
    }
    
    func ref_gettable(_ model:Codable, _ URL: String, _ getRefreshHeaders:HTTPHeaders, method:HTTPMethod = .get, completion: @escaping (Result<networkResult> ) -> Void) {
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking SUCCESS")
            return
        }
        
        print("URL: \(encodedUrl)")
        
        
        Alamofire.request(encodedUrl, method: method, parameters: nil, headers: getRefreshHeaders)
            .responseData {
                res in
                switch res.result {
                case .success:
                    if let value = res.result.value {
                        print("Networking Get Here!")
                        print(JSON(value))
                        
                        let resCode = self.gino(res.response?.statusCode)
                        print(resCode)
                        

                        //성공 모델
                        if JSON(value) == JSON.null {

                            let result : networkResult = (resCode, model) as! (resCode: Int, resResult: Self.NetworkData)
                            completion(.success(result))
                            break
                            
                        }
                        
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            print(("[해당 API에 접근 성공]"))
                            let data = try decoder.decode(NetworkData.self, from: value)
                            
                            let result: networkResult = (resCode, data)
                            completion(.success(result))
                                
                        } catch (let error) {
                            print("catch GET: \(error.localizedDescription)")
                            completion(.error("\(resCode)"))
                        }
                    }
                    break
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                    completion(.failure(error))
                }
        }
    }

}
