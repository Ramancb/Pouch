//
//  OTPTextField.swift
//  Pouch
//
//  Created by Admin on 03/02/23.
//

import UIKit
import Foundation

protocol MyOTPTFDelegate: AnyObject {
    func textFieldDidDelete(_ textField: UITextField)
}

class MyOTPTF: UITextField {
    weak var myDelegate: MyOTPTFDelegate?
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete(self)
    }
}
