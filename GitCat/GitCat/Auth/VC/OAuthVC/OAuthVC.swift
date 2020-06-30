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

class OAuthVC: UIViewController , WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
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
        
        let canAccessPrivateRepo = UserDefaults.standard.bool(forKey: "canAccessPrivate")
        var OAuthURL:URL!
        
        if canAccessPrivateRepo {
            OAuthURL = URL(string: "https://a.gitcat.app/api/auth/github")
        } else {
            OAuthURL = URL(string: "https://a.gitcat.app/api/auth/github-public")
        }

        let request = URLRequest(url: OAuthURL!)
        
        webView.load(request)
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "authCheckHandler" {
            //복호
            let messageBody:String? = message.body as?  String

            let messageData:String?
            
            messageData = try! messageBody?.aesDecrypt()

            //복호화한 데이터 json으로 변형
            //FIXME - 현재 복호화된 데이터가 잘려서 날아와서 온전한 json 형태로 전환 불가
            let str = gsno(messageData)
            let replaceStr = str.replacingOccurrences(of: "h.eu", with: "{\"gi")
            print(replaceStr)
            let dict = convertToDictionary(text: replaceStr)
            
            //복호화한 데이터 저장
            let values:[String:Any] = dict ?? [:]
            let userId = gsno(values["githubId"] as? String)
            let userImage = gsno(values["profileImg"] as? String)
            let token = gsno(values["token"] as? String)
            let isFirst = gbno(values["isFirst"] as? Bool)
            let refreshToken = gsno(values["refreshToken"] as? String)
            let isMatchScope = gbno(values["isMatchScope"] as? Bool)
            
            print("새로운 토큰:\(token)")
            print("refresh 토큰:\(refreshToken)")
            
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(userImage, forKey: "userImage")
            UserDefaults.standard.set(token, forKey: "token")
            UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
            
            putDeviceToken()
            
            if !isMatchScope {
                let cancleModeAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
                    self.putAccess()
                }
                
                let confirmModeAction = UIAlertAction(title: "확인", style: .destructive) { (action) in
                    if isFirst {
                        UserDefaults.standard.set(false, forKey: "signUp")
                        UserDefaults.standard.set(false, forKey: "tutorialDone")
                        
                        let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo3VC")
                        dvc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(dvc, animated: true)
                        
                    }else{
                        UserDefaults.standard.set(true, forKey: "login")
                        UserDefaults.standard.set(true, forKey: "signUp")
                        UserDefaults.standard.set(true, forKey: "tutorialDone")
                                       
                        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "UserDataInitVC")
                        dvc.modalPresentationStyle = .fullScreen
                        self.present(dvc, animated: true, completion: nil)
                    }
                }
                       
                let alert = UIAlertController(title: "접근 권한 변경", message: "이전 설정과 다릅니다. 계속하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(confirmModeAction)
                alert.addAction(cancleModeAction)
                       
                present(alert, animated:true)
            } else {
                if isFirst {
                    UserDefaults.standard.set(false, forKey: "signUp")
                    UserDefaults.standard.set(false, forKey: "tutorialDone")
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo3VC")
                    dvc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(dvc, animated: true)
                    
                }else{
                    UserDefaults.standard.set(true, forKey: "login")
                    UserDefaults.standard.set(true, forKey: "signUp")
                    UserDefaults.standard.set(true, forKey: "tutorialDone")
                    
                    let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "UserDataInitVC")
                    
                    dvc.modalPresentationStyle = .fullScreen
                    self.present(dvc, animated: true, completion: nil)
                }
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
            
            let networkCheckAlert = UIAlertController(title: "네트워크 오류", message: "잠시 후에 다시 시도해주세요!", preferredStyle: UIAlertController.Style.alert)
            
            networkCheckAlert.addAction(UIAlertAction(title: "네", style: .default, handler: { (action:UIAlertAction) in
                print("로그인 화면으로 돌아가기")
            }))
            self.present(networkCheckAlert, animated: true, completion: nil)
        }
    }
}

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
