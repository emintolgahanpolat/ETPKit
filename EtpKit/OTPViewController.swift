//
//  OTPViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 24.09.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet var otpView: OTPFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        otpView.fieldsCount = 6
        otpView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OTPViewController:OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        showAlert(title: "OTP TEXT", message: otp)
    }
}
