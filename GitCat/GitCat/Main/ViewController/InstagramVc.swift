//
//  InstagramVc.swift
//  GitCat
//
//  Created by 조윤영 on 24/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import WebKit
import SystemConfiguration

class InstagramVc: UIViewController , WKUIDelegate, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func loadView() {
        super.loadView()

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

        let InstagramURL = URL(string: "https://instagram.com/gitcat_story")
        let request = URLRequest(url: InstagramURL!)
        
        webView.load(request)
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
