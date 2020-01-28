//
//  OAuthVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import WebKit

class OAuthVC: UIViewController , UIWebViewDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    let OAuthURL = URL(string: "https://a.chameleon4switch.cf/auth/github")
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = URLRequest(url: OAuthURL!)
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }
    
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//        print("shouldStartLoadWith")
//        
////
////        if ( self.webView!.url?.absoluteURL == OAuthURL)
////        {
//            print("SUCCESS")
//            self.webView!.stopLoading()
//            // do something here, like remove this from the nav controller
//            self.navigationController?.popViewController(animated: true)
//        return true
//    }
//    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        
//         print("didReceiveServerRedirectForProvisionalNavigation")
//        if ( self.webView!.url?.absoluteURL == OAuthURL)
//        {
//            print("SUCCESS")
//            self.webView!.stopLoading()
//            // do something here, like remove this from the nav controller
//            self.navigationController?.popViewController(animated: true)
//        }
//        
//    }

    

    

}
