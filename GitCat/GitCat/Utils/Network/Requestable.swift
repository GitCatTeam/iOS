//
//  Requestable.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

protocol Requestable {
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func get(_ URL: String, method: HTTPMethod, completion: @escaping (Result<networkResult>) -> Void)
}

extension Requestable {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func getable(_ URL: String, method: HTTPMethod = .get, completion: @escaping (Result<networkResult>) -> Void) {
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL은 \(encodedUrl)")
        
        Alamofire.request(encodedUrl, method: method, parameters: nil, headers: nil)
            .responseData {
                res in
                switch res.result {
                case .success:
                    if let value = res.result.value {
                        print("Networking Get Here!")
                        print(JSON(value))
                        
                        let responseCode = self.gino(res.response?.statusCode)
                        print(responseCode)
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            print("[해당 API에 접근 성공]")
                            let data = try decoder.decode(NetworkData.self, from: value)
                            
                            let result: networkResult = (responseCode, data)
                            completion(.success(result))
                            
                        } catch (let error) {
                            print("catch GET: \(error.localizedDescription)")
                            completion(.error("\(responseCode)"))
                        }
                    }
                    break
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                    completion(.failure(error))
                }
        }
    }
    
    func postable<T: Codable>(url: String, type: T.Type, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (T?, Error?) -> Void) {
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            
                            completion(result, nil)
                        } catch (let error) {
                            print("catch: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                    completion(nil, error)
                }
        }
    }
    
    func putalbe<T: Codable>(url: String, type: T.Type, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (T?, Error?) -> Void) {
        Alamofire.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            
                            completion(result, nil)
                        } catch (let error) {
                            print("catch: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                    completion(nil, error)
                }
        }
    }
    
    func delete<T: Codable>(url: String, type: T.Type, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (T?, Error?) -> Void) {
        Alamofire.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            
                            completion(result, nil)
                        } catch (let error) {
                            print("catch: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                    completion(nil, error)
                }
        }
    }
}
