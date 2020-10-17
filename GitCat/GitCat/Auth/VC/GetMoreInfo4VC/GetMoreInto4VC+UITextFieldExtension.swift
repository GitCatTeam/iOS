//
//  GetMoreInto4VC+UITextFieldExtension.swift
//  
//
//  Created by 조윤영 on 2020/06/20.
//

import UIKit

extension GetMoreInfo4VC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        print(currentCharacterCount)
        
           if range.length + range.location > currentCharacterCount {
               return false
           }
           let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 9
    }
}
