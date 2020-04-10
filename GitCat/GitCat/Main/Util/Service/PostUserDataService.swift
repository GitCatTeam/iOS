//
//  PostUserDataService.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation


struct PostUserDataService: PosttableService, APIServie {
    
    typealias NetworkData = CommonModel
    static let shareInstance = PostUserDataService()
    
    //MARK: POST - https://a.gitcat.app/api/home/commits (로딩과정에서 사용자의 Github 커밋 데이터 불러오기 API)
    
    func checkTokenExpired() {
        //토큰 복호화 함수
        func decode(jwtToken jwt: String) -> [String: Any] {
          let segments = jwt.components(separatedBy: ".")
          return decodeJWTPart(segments[1]) ?? [:]
        }

        func base64UrlDecode(_ value: String) -> Data? {
          var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

          let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
          let requiredLength = 4 * ceil(length / 4.0)
          let paddingLength = requiredLength - length
          if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
          }
          return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }

        func decodeJWTPart(_ value: String) -> [String: Any]? {
          guard let bodyData = base64UrlDecode(value),
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
              return nil
          }

          return payload
        }
        
        //TODO - 라이브러리 걷어내기
        //만약 토큰이 만료되었다면 갱신
        let decodeToken = decode(jwtToken: UserDefaults.standard.string(forKey:"token")!)
        let expDate = decodeToken["exp"]
        print(expDate)
        if let timeResult = (expDate as? Double) {
             let date = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = NSTimeZone() as TimeZone
            let localDate = dateFormatter.string(from: date as Date)
            print("==============================================")
            print(localDate)
            print("==============================================")
        }
        
        
        
        
    }
    func postUserData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let userDataURL = self.url("/home/commits")
        
        
        //커밋 데이터 업데이트
        post(userDataURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
                default :
                    print("Error: \(resCode)")
                    break
                }
                break
                
            case .failure(_):
                completion(.networkFail)
                print("Fail: Network Fail")
                break
            case .noContents:
                break
            }
        }
        
    }
}
