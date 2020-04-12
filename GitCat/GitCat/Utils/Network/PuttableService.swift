//
//  PuttableService.swift
//  GitCat
//
//  Created by 조윤영 on 28/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

protocol PuttableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func put(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}
let putHeaders: HTTPHeaders = [
    "Authorization":UserDefaults.standard.string(forKey: "token") ?? "",
    "Content-Type":"application/json"
]

extension PuttableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func put(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void){
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL: \(encodedUrl)")
        
        Alamofire.request(encodedUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: putHeaders).responseData(){
            (res) in
            
            switch res.result {
            case .success:
                
                print("Networking Put Here")
                print(params)
                
                if let value = res.result.value {
                    let resCode = self.gino(res.response?.statusCode)
                    print(resCode)
                    
                    print(JSON(value))
                    
                    //성공 모델
                    if JSON(value) == JSON.null {
                        
                        let result : networkResult = (resCode, CommonModel()) as! (resCode: Int, resResult: Self.NetworkData)
                        completion(.success(result))
                        break
                        
                    }
                    
                    let decoder = JSONDecoder()
                    
                    //실패 모델
                    do {
                        
                        let resData = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, resData)
                        
                        completion(.success(result))
                    }catch{ //변수 문제 예외 예상
                        print("Catch Put")
                        
                        
                        completion(.error("\(resCode)"))
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(err))
                break
            }
        }
        
        
    }
}

