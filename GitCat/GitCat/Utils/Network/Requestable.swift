//
//  Requestable.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//


import Foundation
import Alamofire

protocol Requestable {}

extension Requestable {
    
    func getable<T: Codable>(url: String, type: T.Type, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (T?, Error?) -> Void) {
        Alamofire.request(url, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header)
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
