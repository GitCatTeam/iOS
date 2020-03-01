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

public class Reachabilty : Decrytion{
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

    @IBOutlet weak var webView: WKWebView!
    
    
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
        loadURL()
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
       


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        checkNetworkConnect()
    }
    
    func loadURL() {
        
        
        let OAuthURL = URL(string: "https://a.gitcat.app/api/auth/github")
        
        let request = URLRequest(url: OAuthURL!)
        
        webView.load(request)
        
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if(message.name == "authCheckHandler") {
            
            //복호화
            print("=====================================")
            print(message.body) //string 형태로 날아옴
            print("=====================================")
        //ehwcZXqJFwK80sv7S++kKRRy6x2njyYl1nZke9Bd5zQEzW3MbAxXa7BctWCbQkJ8ZQbpx04H71pBEdGZ2yQaHPIePUPJiWIqUvEYDjcqDVwiQdp7JaQNyIB1+lF6IieMxYtYDu84tvp04I+M+ovVuQNiWHMYNxoDerVG+ksHYWqCcHpK6t0hdqWBJN/WtlYFj9j2NXWa/BBq7sMMYBrhvbqsC+GRdDtT1NzL4fcTnRLE7sUssBVR8NE/k0w7I4MuZhCbuHOUfqSda8MZqdQpikXBrwNAYJlxD3Jbmz4K8rlXqPsuOxeNXKEEFW3MNpNK91JfBO3M7FA3FmRueZpRSX/7Ba8UGpKySu0NcIdu0oadLvl+5DeKT/llkjZ08KnEw6UMIPW9IzIiiWaGXo0Yz+oyOCwUetbaEmksNFvEV3M=

            let messageBody:String? = message.body as?  String
            
            let messageData:String?
            
            messageData = try! messageBody?.aesDecrypt()
            
            print("복호화됐을까..?\(String(describing: messageData))") //응 안돼
//
//            let messageData:Data! = message.body as!  Data
//            decrypt(data: messageData, keyData: keyData, ivData: ivData)
//
            //복호화한 데이터 저장
            
            let values:[String:AnyObject] = message.body as! Dictionary
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
            
            //DeviceToken 전달
            postDeviceToken()
            
            
            if(isFirst == true) {
                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo1VC")
                dvc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(dvc, animated: true)
                
            }else{
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabC")
                
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

extension OAuthVC {
    func postDeviceToken() {
        
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        
        let params : [String : Any] = [
            "deviceToken" : deviceToken ,
            "os" : "iOS"
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

//extension OAuthVC {
//    static func decryptArtisan(cryptedMessage: String , key:String) -> String? {
//        var clairMessage:String? = nil;
//
//        if let cryptedData = Data(base64Encoded: cryptedMessage) {
//            do {
//                let aes = try AES(key: Array<UInt8>(key.utf8), blockMode: ECB(), padding: .pkcs5) // aes128
//                let cipher = try aes.decrypt(Array<UInt8>(cryptedData))
//                clairMessage = String(bytes: cipher, encoding: .utf8)
//            }catch{
//                let error = error as NSError
//                print(error)
//            }
//        }
//
//        return clairMessage
//    }
//}



func dataToByteArray(data: NSData) -> [UInt8] {
    let pointer = data.bytes.assumingMemoryBound(to: UInt8.self)
    
    let buffer = UnsafeBufferPointer(start: pointer, count: data.length)
    
    return Array<UInt8>(buffer)
}

let keyData = Secrets.PrivatekeyData
let ivData = Secrets.PrivateivData


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
        print("encryptedData:\(encryptedData)")
        let encryptedBytes: [UInt8] = dataToByteArray(data: encryptedData)
        print("encryptedBytes:\(encryptedBytes)")
        let decryptedBytes: [UInt8] = try AES(key: key, blockMode: CBC(iv: iv)).decrypt(encryptedBytes)
        print("decryptedBytes:\(decryptedBytes)") //여기까지 복호화한 것 같긴한데..

//        let decryptedString: String = bytesToString(bytes: decryptedBytes)
//        print("Decrypted String Length: " + String(decryptedBytes.characters.count))
//        print("Decrypted String:")
//        print(decryptedString)
//        print("")
        

//        let str = String(decoding: decryptedBytes, as: UTF8.self)
        
//        let ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: 488)
//        let bPtr = UnsafeMutableBufferPointer<UInt8>(start:ptr, count: 488)
//
//        for (i, c) in decryptedBytes.enumerated() {
//            bPtr[i] = c
//        }
//

//        // 시작번지를 가져와서...
//        let string = String(cString:bPtr.baseAddress!)
//        print("================================")
//        print("1")
//        print(string) // "hello"
//        print("================================")
    /*�k'^��3'*ӣ�p���0�����u�xZ��fa�Ώ�Fe�7V練A׃B}=��*�A��As��sP`#�8�̾���M��'�W��0����a�!V�)!E��M�{�����^F���Bt�o���̄"��̭6�.��@)����:I�}���1i���$��7�΂�<J��b[�w�P\/X��x>~�Փ4��B�h���0��ybOx���'�< �>��҈�r�o�k̮�BB=[>Hdr�9�F��T��Đsz"���^�n���%;,�
        i�A���
        �_�e�u�:��F����8Gޑ"G��b٣̑�s���_@Ym*/
//
//        let string2 = String(bytes:bPtr, encoding: .utf8)
//        print("================================")
//        print("2")
//        print(string2) // "hello"
//        print("================================")
        

//        return string ?? "흥"
        return String(bytes: decryptedBytes, encoding: .utf8)!

    }

//    func bytesToString(bytes: Array<UInt8>) -> String {
//        var encodedString = ""
//        var decoder = UTF8()
//        var generator = bytes.generate()
//        var finished: Bool = false
//        repeat {
//            let decodingResult = decoder.decode(&generator)
//            switch decodingResult {
//            case .Result(let char):
//                encodedString.append(char)
//            case .EmptyInput:
//                finished = true
//            case .Error:
//                finished = true
//            }
//        } while (!finished)
//        return encodedString
//    }
//
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
