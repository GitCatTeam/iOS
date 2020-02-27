//
//  GettableService.swift
//  GitCat
//
//  Created by 조윤영 on 22/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

protocol GettableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func gettable(_ URL: String, method: HTTPMethod, completion: @escaping (Result<networkResult>) -> Void)
}

let getHeaders: HTTPHeaders = [
    "Authorization":UserDefaults.standard.string(forKey: "token") ?? ""
]

extension GettableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    
    func gettable(_ URL: String, method:HTTPMethod = .get, completion: @escaping (Result<networkResult>) -> Void) {
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking SUCCESS")
            return
        }
        
        print("URL: \(encodedUrl)")
        
        
        Alamofire.request(encodedUrl, method: method, parameters: nil, headers: getHeaders)
            .responseData {
                res in
                switch res.result {
                case .success:
                    if let value = res.result.value {
                        print("Networking Get Here!")
                        print(JSON(value))
                        
                        let resCode = self.gino(res.response?.statusCode)
                        print(resCode)
                        
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
