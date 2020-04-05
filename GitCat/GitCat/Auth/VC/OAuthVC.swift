//
//  OAuthVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import Foundation
import WebKit
import SystemConfiguration
import CryptoSwift

public class Reachabilty{
    
    class func isConnectedToNetwork() ->Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr:0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        //Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConenction = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConenction)
        
        return ret
    }
}

class OAuthVC: UIViewController , WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler{

    @IBOutlet var webView: WKWebView!
    
    
    override func loadView() {
        super.loadView()
        //JavaSciprt와 Native 영역과의 통신을 위한 Bridge Name을 등록해주는 WKUserContentController, WKWebViewConfiguration을 정의해준다.
        let userContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        //Bridge Name에 등록된 이름은 Serverside JavaScript에도 함수로 정의되어 있어야 한다. 등록한 설정정보를 WKWebViewConfiguration에 등록해준다.그리고 해당 config 정보를 웹 뷰 정의 시 등록해준다.
        userContentController.add(self, name: "authCheckHandler")
        
        config.userContentController = userContentController
        
        webView = WKWebView(frame:view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view.addSubview(webView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteCache()
        loadURL()
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        checkNetworkConnect()
    }
    
    func deleteCache() {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {
            (records) -> Void in
            for record in records{
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
               //remove callback
            }
        })
    }
    
    func loadURL() {
        
        let OAuthURL = URL(string: "https://a.gitcat.app/api/auth/github")
        
        let request = URLRequest(url: OAuthURL!)
        
        webView.load(request)
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if(message.name == "authCheckHandler") {
            
            //복호
            let messageBody:String? = message.body as?  String
            
            print("=================최초 string======================")
            print("\(messageBody ?? "")")
            print("=================최초 string======================")
            let messageData:String?
            
            messageData = try! messageBody?.aesDecrypt()
            
            print("=================복호화======================")
            print("\(gsno(messageData))")
            print("=================복호화======================")

            
            //복호화한 데이터 json으로 변형
            //FIXME - 현재 복호화된 데이터가 잘려서 날아와서 온전한 json 형태로 전환 불가
            let str = gsno(messageData)
            let replaceStr = str.replacingOccurrences(of: "h.eu", with: "{\"gi")
            print("=================복호화 결과 변경======================")
            print(replaceStr)
            print("=================복호화 결과 변경======================")

            let dict = convertToDictionary(text: replaceStr)
            print("================JSON======================")
            print("\(dict ?? [:])")
            print("=================JSON======================")
            
            
            
            //복호화한 데이터 저장
            let values:[String:Any] = dict ?? [:]
            let userId = gsno(values["githubId"] as? String)
            let userImage = gsno(values["profileImg"] as? String)
            let token = gsno(values["token"] as? String)
            let isFirst = gbno(values["isFirst"] as? Bool)
            
            print("[로그인 회원정보 가져오기 성공]")
            print("email:\(userId)")
            print("image:\(userImage)")
            print("token:\(token)")
            print("isFirst\(isFirst)")
            
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(userImage, forKey: "userImage")
            UserDefaults.standard.set(token, forKey: "token")
            
            //FIXME: DeviceToken 전달
//            postDeviceToken()
            
            
            if(isFirst == true) {
                UserDefaults.standard.set(false, forKey: "tutorialDone")
                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo1VC")
                dvc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(dvc, animated: true)
                
            }else{
                UserDefaults.standard.set(true, forKey: "login")
                UserDefaults.standard.set(true, forKey: "tutorialDone")
                
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "UserDataInitVC")
                
                dvc.modalPresentationStyle = .fullScreen
                
                self.present(dvc, animated: true, completion: nil)
            }

        }
    }
    
    //중복적 리로드 방지
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    //Network 연결상태 검사
    func checkNetworkConnect() {
        if(Reachabilty.isConnectedToNetwork()) {
            print("Network Conencted")
        } else{
            print("Network Error:Github 연동 로그인 시 네트워크 연결이 되어 있지 않음.")
            
            let networkCheckAlert = UIAlertController(title: "네트워크 오류", message: "네트워크 연결 상태를 확인해주세요", preferredStyle: UIAlertController.Style.alert)
            
            networkCheckAlert.addAction(UIAlertAction(title: "네", style: .default, handler: { (action:UIAlertAction) in
                print("로그인 화면으로 돌아가기")
            }))
            self.present(networkCheckAlert, animated: true, completion: nil)
        }
    }
}

//Networking
extension OAuthVC {
    func postDeviceToken() {
        
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        UserDefaults.standard.set(UUID().uuidString, forKey: "UUID")
        let uuid = UserDefaults.standard.string(forKey: "UUID")
        
        let params : [String : Any] = [
            "deviceToken" : deviceToken ,
            "os" : "iOS",
            "deviceId": uuid!
        ]
        
        PostDeviceTokenService.shareInstance.postDeviceToken(params: params) {(result) in
                switch result {
                case .networkSuccess( _): //201
                    print("Device Token POST SUCCESS")
                    break
                    
                //FIXME: 수정
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                    
                case .duplicated: //401
                    
                    self.simpleAlert(title: "", message: "권한이 없습니다.")
                    break
                    
                case .networkFail:
                    self.networkErrorAlert()
                    break
                    
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        }
    }
}

//복호화 관련 함수
extension OAuthVC {
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

let keyData = Secrets.PrivatekeyData
let ivData = Secrets.PrivateivData

func dataToByteArray(data: NSData) -> [UInt8] {
    let pointer = data.bytes.assumingMemoryBound(to: UInt8.self)
    
    let buffer = UnsafeBufferPointer(start: pointer, count: data.length)
    
    return Array<UInt8>(buffer)
}

extension String {

    func aesEncrypt() throws -> String {
        let encrypted = try AES(key: keyData, iv: ivData).encrypt([UInt8](self.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }
    
    func aesDecrypt() throws -> String {
        
        let key: [UInt8] = Array(keyData.utf8)
        let iv: [UInt8] = Array(ivData.utf8)
        print("key:\(key)")
        print("iv:\(iv)")
        
        let encryptedData: NSData = self.hexStringToData()
//        let encryptedBytes: [UInt8] = dataToByteArray(data: encryptedData)
//        let decryptedBytes: [UInt8] = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5).decrypt(encryptedBytes)
        
        let decrypted = try AES(key: keyData, iv: ivData, padding: .pkcs7).decrypt([UInt8](encryptedData))

        return String(bytes: decrypted, encoding: .utf8)!
    }

    func hexStringToData() -> NSData {
        let data = NSMutableData()
        var temp = ""
        for char in self {
            temp += String(char)
            if temp.count == 2 {
                let scanner = Scanner(string: temp)
                var value: CUnsignedInt = 0
                scanner.scanHexInt32(&value)
                data.append(&value, length: 1)
                temp = ""
            }
        }
        return data as NSData
    }
}
