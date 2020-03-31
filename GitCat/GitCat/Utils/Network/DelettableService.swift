//
//  DelettableService.swift
//  GitCat
//
//  Created by 조윤영 on 27/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

let deleteHeaders: HTTPHeaders = [
    "Authorization": UserDefaults.standard.string(forKey: "token") ?? "",
    "Content-Type": "application/json"
]

protocol DelettableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func delete(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}

extension DelettableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func delete(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void){
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL은 \(encodedUrl)")

        
        Alamofire.request(encodedUrl, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: deleteHeaders).responseData(){
            (res) in
            
            switch res.result {
            case .success:
                
                print("Networking Delete Here")
                
                if let value = res.result.value {
                    let resCode = self.gino(res.response?.statusCode)
                    print(resCode)
                    
                    if(resCode == 204){
                        completion(.noContents)
                    }else{
                        print(JSON(value))
                        
                        //성공 모델
                        if JSON(value) == JSON.null {
                            
                            let result : networkResult = (resCode, DefaultData()) as! (resCode: Int, resResult: Self.NetworkData)
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
                            print("Catch Delete")
                            
                            completion(.error("\(resCode)"))
                        }
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

