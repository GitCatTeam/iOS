//
//  GetAccessVC.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/26.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class GetAccessVC: UIViewController {
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var subtitle1Label: CustomLabel!
    @IBOutlet weak var subtitle2Label: CustomLabel!
    @IBOutlet weak var miniSubTitleLabel: CustomLabel!
    
    @IBOutlet weak var publicView: UIView!
    @IBOutlet weak var publicTitleLabel: CustomLabel!
    @IBOutlet weak var publicSubTitle1Label: CustomLabel!
    @IBOutlet weak var publicSubTitle2Label: CustomLabel!
    @IBOutlet weak var publicCheckBoxImage: UIImageView!
    @IBOutlet weak var publicDesc1Label: CustomLabel!
    @IBOutlet weak var publicDesc2Label: CustomLabel!
    
    @IBOutlet weak var privateView: UIView!
    @IBOutlet weak var privateTitleLabel: CustomLabel!
    @IBOutlet weak var privateSubTitle1Label: CustomLabel!
    @IBOutlet weak var privateSubTitle2Label: CustomLabel!
    @IBOutlet weak var privateCheckBoxImage: UIImageView!
    @IBOutlet weak var nextBtn: RoundBtn!
    @IBOutlet weak var privateDesc1Label: UILabel!
    @IBOutlet weak var privateDesc2Label: UILabel!
    @IBOutlet weak var privateDesc3Label: UILabel!
    
    var canAccessPrivate:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.nextBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.canAccessPrivate = true
        self.nextBtn.isEnabled = false
        setStyle()
        setAlpha()
    }
    
    func setStyle() {
        self.publicTitleLabel.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.publicView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.publicView.layer.borderWidth = 1.0
        self.publicView.roundRadius(radius: 12)
        
        self.privateTitleLabel.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.privateView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.privateView.layer.borderWidth = 1.0
        self.privateView.roundRadius(radius: 12)
        
        self.nextBtn.addShadow()
        self.nextBtn.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8588235294, blue: 0.8352941176, alpha: 1)
    }
    
    func setAlpha() {
        self.publicCheckBoxImage.alpha = 0
        self.privateCheckBoxImage.alpha = 0
        
        self.publicDesc1Label.alpha = 0
        self.publicDesc2Label.alpha  = 0
        self.privateDesc1Label.alpha  = 0
        self.privateDesc2Label.alpha =  0
        self.privateDesc3Label.alpha = 0
    }
    
    func setFontSize() {
        self.titleLabel.dynamicFont(fontSize: 22, name: "BBTreeG_B")
        self.subtitle1Label.dynamicFont(fontSize: 13, name: "BBTreeGo_R")
        self.subtitle2Label.dynamicFont(fontSize: 13, name: "BBTreeGo_R")
        self.miniSubTitleLabel.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        
        self.publicTitleLabel.dynamicFont(fontSize: 18, name: "BBTreeG_B")
        self.publicSubTitle1Label.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.publicSubTitle2Label.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.publicDesc1Label.dynamicFont(fontSize: 15, name: "BBTreeG_B")
        self.publicDesc2Label.dynamicFont(fontSize: 15, name: "BBTreeG_B")
        
        self.privateTitleLabel.dynamicFont(fontSize: 18, name: "BBTreeG_B")
        self.privateSubTitle1Label.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.privateSubTitle2Label.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.privateDesc1Label.dynamicFont(fontSize: 15, name: "BBTreeG_B")
        self.privateDesc2Label.dynamicFont(fontSize: 15, name: "BBTreeG_B")
        self.privateDesc3Label.dynamicFont(fontSize: 15, name: "BBTreeG_B")
    }
    
    @IBAction func publicSelectAction(_ sender: Any) {
        self.canAccessPrivate = false
        self.nextBtn.isEnabled = true
        self.nextBtn.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        
        self.publicTitleLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        self.privateTitleLabel.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.publicView.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        self.privateView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.publicCheckBoxImage.alpha = 1
        self.privateCheckBoxImage.alpha = 0
        
        self.privateCheckBoxImage.alpha = 0
        self.privateDesc1Label.alpha  = 0
        self.privateDesc2Label.alpha =  0
        self.privateDesc3Label.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.publicCheckBoxImage.alpha = 1
            self.publicDesc1Label.alpha = 1
            self.publicDesc2Label.alpha  = 1
        });
        
    }
    
    @IBAction func privateSelectAction(_ sender: Any) {
        self.canAccessPrivate = true
        self.nextBtn.isEnabled = true
        self.nextBtn.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)

        self.privateTitleLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        self.publicTitleLabel.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.privateView.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        self.publicView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.privateCheckBoxImage.alpha = 1
        self.publicCheckBoxImage.alpha = 0
        
        self.publicCheckBoxImage.alpha = 0
        self.publicDesc1Label.alpha = 0
        self.publicDesc2Label.alpha  = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.privateCheckBoxImage.alpha = 1
            self.privateDesc1Label.alpha  = 1
            self.privateDesc2Label.alpha =  1
            self.privateDesc3Label.alpha = 1
        })
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        UserDefaults.standard.set(self.canAccessPrivate, forKey: "canAccessPrivate")

        let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "OAuthVC")
        dvc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
