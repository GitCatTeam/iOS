//
//  PosttableService.swift
//  GitCat
//
//  Created by 조윤영 on 27/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PosttableService {
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func post(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}

private var alamoFireManager: SessionManager? = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 180000
    configuration.timeoutIntervalForResource = 180000
    let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    return alamoFireManager
}()

extension PosttableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func post(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void){
        
        let postHeaders: HTTPHeaders = [
            "Authorization":UserDefaults.standard.string(forKey: "token")!,
            "Content-Type":"application/json"
        ]
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL: \(encodedUrl)")
        
        
        alamoFireManager?.request(encodedUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: postHeaders).responseData(){
            (res) in
            
            switch res.result {
            case .success:
                print("Networking Post Here")
                
                if let value = res.result.value {
                    let resCode = self.gino(res.response?.statusCode)
                    print(resCode)
                    
                    print(JSON(value))
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let resData = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, resData)
                        
                        completion(.success(result))
                        
                    }catch{ //변수 문제 예외 예상
                        completion(.error("\(resCode)"))
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(err))
                if let err = res.result.error {
                    if(err._code == NSURLErrorTimedOut) {
                        print("타임에러야 발생")
                    }
                }
                break
            }
        }
    }
}
