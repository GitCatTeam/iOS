//
//  OAuthVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import WebKit
import SystemConfiguration
public class Reachabilty {
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
            let values:[String:AnyObject] = message.body as! Dictionary
            let userEmail = gsno(values["githubId"] as? String)
            let userImage = gsno(values["profileImg"] as? String)
            let token = gsno(values["token"] as? String)
            let isFirst = gbno(values["isFirst"] as? Bool)
            
            print("[로그인 회원정보 가져오기 성공]")
            print("email:\(userEmail)")
            print("image:\(userImage)")
            print("token:\(token)")
            print("isFirst\(isFirst)")
            
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
            UserDefaults.standard.set(userImage, forKey: "userImage")
            UserDefaults.standard.set(token, forKey: "token")
            
            
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
