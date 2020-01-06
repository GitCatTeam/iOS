//
//  AuthService.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Alamofire

struct AuthService: Requestable {
    
    //MARK: GET - https://github.com/login/oauth/authorize?client_id (Github 로그인을 통한 Personal Access Token 교환 코드 발급
    
    static let shared = AuthService()
    
    
    func getSignInCode(_ state:String, _ clientId:String, completion: @escaping (SignInCodeData?, Error?) -> Void) {
        let url = "https://github.com/login/oauth/authorize?client_id=\(clientId)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(SignInCodeData.self, from: data)
                            completion(result, nil)
                        } catch (let error) {
                            print("error! \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("failure! \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
    
    func postAccessToken(_ client_id:String, _ client_secret:String, _ code:String, completion: @escaping  (TokenResponse?, Error?) -> Void) {
        let url = "https://github.com/login/oauth/access_token?client_id=\(client_id)?client_secret=\(client_secret)?code=\(code)"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default,headers: nil).responseData() {
            res in
            switch res.result {
            case .success:
                if let data = res.data {
                    do {
                        let result = try JSONDecoder().decode(TokenResponse.self, from: data)
                        
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
//    typealias NetworkData = ResponseObject<Home>
//    static func getSignInCode(clientId: String, completion: @escaping (Result<[SignInCodeData]>) -> Void) {
//        let header: HTTPHeaders = [
//             "Content-Type" : "application/json"
//        ]
//
//        let myCodeURL = "https://github.com/login/oauth/authorize?client_id=262e39bf3d85a134e1eb"
//
//        Alamofire.request(myCodeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData() { res in
//                switch res.result {
//
//                //서버 연결 성공
//                case .success:
//
//                    /* 아래의 if-let 구문은 옵셔널 타입을 안전하게 추출하기 위해 사용합니다.
//                     Optional 타입이란 값이 있을 수도 없을 수도 있는 경우를 위한 타입입니다.
//                     해당 value 값은 data 형의 값이 있을 수도 없을 수도 있는 상태이기 때문에
//                     안전하게 옵셔널 해제를 해주기 위해서 아래와 같은 구문을 사용하였습니다.
//                     */
//
//                    //결과값이 있는지 확인합니다.
//                    if let value = res.result.value {
//
//                        let decoder = JSONDecoder()
//
//                        do {
//                            //Codable로 정의된 music 모델에 맞게 디코딩을 합니다.
//                            let data = try decoder.decode(SignInCodeData.self, from: value)
//                            completion(data)
//
//                        } catch {
//                            /* catch 문으로 오게되면 제대로 디코딩이 이루어지지 못한 것입니다.
//                             보통 codable 실수가 대부분입니다.
//                             변수명이 틀렸거나 타입 값이 일치하지 않거나 널처리를 제대로 하지 않은 이유입니다.
//                             */
//                            print("변수 문제")
//                        }
//                    }
//
//                    break
//
//                //서버 연결 실패
//                case .failure(let err):
//
//                    //에러를 출력해줍니다.
//                    print(err.localizedDescription)
//                    break
//                }
//            }
//        }
//
}


