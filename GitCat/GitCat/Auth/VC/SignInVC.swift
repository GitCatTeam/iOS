//
//  SignInVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import WebKit
import Alamofire

class SignInVC: UIViewController , UIWebViewDelegate{
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var clientID: String = ""
    

    
//    Auth().currentUser.reauthenticateWithCredential(withCredential: credential) { authResult, error in
//      if error != nil {
//        // Handle error.
//      }
//      // User is re-authenticated with fresh tokens minted and
//      // should be able to perform sensitive operations like account
//      // deletion and email or password update.
//      // IdP data available in result.additionalUserInfo.profile.
//      // Additional OAuth access token is can also be retrieved by:
//      // authResult.credential.accessToken
//      // GitHub OAuth ID token can be retrieved by calling:
//      // authResult.credential.idToken
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loginBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        loginBtn.addShadow()

    }

    @IBAction func signInTouchUpAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.normal)
        
        AuthService.shared.getSignInCode("testhi", "262e39bf3d85a134e1eb") { (res, err) in
            
        }

        AuthService.shared.postAccessToken("262e39bf3d85a134e1eb", "secret_key", "testhi") { (res, err) in
            print(res?.access_token)
        }
    
        
        /*Github Login API - Using Firebase*/
        let provider = OAuthProvider(providerID: "github.com")
        provider.customParameters = [
            "allow_signup": "false"
        ]
        // Request read access to a user's email addresses.
        // This must be preconfigured in the app's API permissions.
        provider.scopes = ["user:email"]
    
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            if credential != nil {
                
                Auth.auth().signIn(with: credential!) { authResult, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    print("===================print==========================")
                    print("로그인에 성공했습니다.")
                    print("refreshToken:\(authResult?.user.refreshToken)")
                    authResult?.user.getIDTokenResult(completion: { (result, error) in
                        print("tokenResult:\(result?.token)")
                    })
                    authResult?.user.getIDToken(completion: { (result, error) in
                        print("token:\(result)")
                    })

                   print("**************************************************")
                    print("profile:\(authResult?.additionalUserInfo?.profile)")
//                    print("username\(authResult?.additionalUserInfo.)")"
//                        additionalUserInfo?.username)")
                    print("image:\(authResult?.user.photoURL)")
                    print("phoneNumber:\(authResult?.user.phoneNumber)")
                    print("name:\(authResult?.user.displayName)")
                    print("email\(authResult?.user.email)")
                    print("uid\(authResult?.user.uid)")
                    
                    print("??\(authResult?.credential?.accessibilityValue)")
                    
                    
                    print("===================print==========================")


                    // User is signed in.
                    // IdP data available in authResult.additionalUserInfo.profile.
                    // GitHub OAuth access token can also be retrieved by:
                    // authResult.credential.accessToken

                    // GitHub OAuth ID token can be retrieved by calling:
                    // authResult.credential.idToken
                  }
                }
              }
        
        //상태에 따른 이동
        //if github 계정이 있다면?
        
        if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo1VC") as? GetMoreInfo1VC {

            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func signInTouchDownAction(_ sender: UIButton) {
      
        
        sender.backgroundColor = UIColor.CustomColor.skyBlue
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
}


extension SignInVC {
    func getCode() {
        Alamofire.request("https://github.com/login/oauth/authorize?client_id=262e39bf3d85a134e1eb", method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"]) .validate(statusCode: 200..<300) .responseJSON { (response) in if let JSON = response.result.value {
            print("***************************")
            print(JSON)
            print("***************************")
            }
            
        }


//       let url = "https://github.com/login/oauth/authorize?client_id=262e39bf3d85a134e1eb"
//        let doNetwork = Alamofire.request(url)
//
//        doNetwork.responseJSON { (response) in
//            switch response.result {
//            case .success(let obj):
//                print(obj)
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
