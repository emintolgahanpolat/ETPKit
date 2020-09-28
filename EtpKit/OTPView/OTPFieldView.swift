//
//  OTPFieldView.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 24.09.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


import UIKit



 protocol OTPFieldViewDelegate: class {
    func enteredOTP(otp: String)
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool
}

 enum KeyboardType: Int {
    case numeric
    case alphabet
    case alphaNumeric
}


@IBDesignable
class OTPFieldView: UIView {
    
    private lazy var containerStackView :UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution  = .equalSpacing
        view.alignment = .fill
        view.spacing   = 2.0
        return view
    }()
    
    
    @IBInspectable var fieldsCount: Int = 6 {
        didSet{
            if fieldsCount < 1 {
                fieldsCount = 1
            }
            initializeOTPFields()
        }
    }
    @IBInspectable var defaultBackground : UIImage? = UIImage(named: "pinDefault") {
        didSet{
            initializeOTPFields()
        }
    }
    @IBInspectable var activeBackground : UIImage? = UIImage(named: "pinActive")
    @IBInspectable var filledBackground : UIImage? = UIImage(named: "pinFilled")
    @IBInspectable var textColor : UIColor = .white
    public var otpInputType: KeyboardType = .numeric
    
    public weak var delegate: OTPFieldViewDelegate?
    
    fileprivate var secureEntryData = [String]()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           initializeUI()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           initializeUI()
       }
    
    
    private func initializeUI() {
       
        addSubview(containerStackView)
        containerStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        containerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true


    }
    
    private func initializeOTPFields() {
        layoutIfNeeded()
        containerStackView.subviews.forEach{$0.removeFromSuperview()}
        secureEntryData.removeAll()
        for index in stride(from: 0, to: fieldsCount, by: 1) {
            let oldOtpField = viewWithTag(index + 1) as? UITextField
            oldOtpField?.removeFromSuperview()
            
            let otpField = getOTPField(forIndex: index)
            
            containerStackView.addArrangedSubview(otpField)
            secureEntryData.append("")
        }
        layoutIfNeeded()
        (viewWithTag(1) as? UITextField)?.becomeFirstResponder()
    }
    
    fileprivate func getOTPField(forIndex index: Int) -> UITextField {
        let otpField = UITextField()
        otpField.translatesAutoresizingMaskIntoConstraints = false
        otpField.widthAnchor.constraint(equalTo: otpField.heightAnchor).isActive = true
        otpField.delegate = self
        otpField.tag = index + 1
        otpField.background = defaultBackground
        otpField.textColor = textColor
        otpField.autocorrectionType = .no
        otpField.tintColor = UIColor.clear
        otpField.textAlignment = .center
        // Set input type for OTP fields
        switch otpInputType {
        case .numeric:
            otpField.keyboardType = .numberPad
        case .alphabet:
            otpField.keyboardType = .alphabet
        case .alphaNumeric:
            otpField.keyboardType = .namePhonePad
        }
        return otpField
    }
    
    
    // Helper function to get the OTP String entered
    fileprivate func calculateEnteredOTPSTring(isDeleted: Bool, isLastCharracter:Bool = false) {
        if isDeleted {
            _ = delegate?.hasEnteredAllOTP(hasEnteredAll: false)
            for index in stride(from: 0, to: fieldsCount, by: 1) {
                var otpField = viewWithTag(index + 1) as? UITextField
                if otpField == nil {
                    otpField = getOTPField(forIndex: index)
                }
            }
        }
        else {
            var enteredOTPString = ""
            for index in stride(from: 0, to: secureEntryData.count, by: 1) {
                if !secureEntryData[index].isEmpty {
                    enteredOTPString.append(secureEntryData[index])
                }
            }
            if enteredOTPString.count == fieldsCount && isLastCharracter {
                delegate?.enteredOTP(otp: enteredOTPString)
                for index in stride(from: 0, to: fieldsCount, by: 1) {
                    var otpField = viewWithTag(index + 1) as? UITextField
                    if otpField == nil {
                        otpField = getOTPField(forIndex: index)
                    }
                }
            }
        }
    }
    
}

extension OTPFieldView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.background = activeBackground
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.background = (textField.text ?? "").isEmpty ? defaultBackground : filledBackground
    }
   
   
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        
        // Check since only alphabet keyboard is not available in iOS
        if !replacedText.isEmpty && otpInputType == .alphabet && replacedText.rangeOfCharacter(from: .letters) == nil {
            return false
        }
        
        if replacedText.count >= 1 {
            // If field has a text already, then replace the text and move to next field if present
            secureEntryData[textField.tag - 1] = string
            
            textField.text = string
            
            
            let nextOTPField = viewWithTag(textField.tag + 1)
            
            if let nextOTPField = nextOTPField {
                nextOTPField.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            calculateEnteredOTPSTring(isDeleted: false, isLastCharracter: textField.tag == fieldsCount )
        }
        else {
            let currentText = textField.text ?? ""
            
            if textField.tag > 1 && currentText.isEmpty {
                if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                    deleteText(in: prevOTPField)
                }
            } else {
                deleteText(in: textField)
                
                if textField.tag > 1 {
                    if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                        
                        prevOTPField.becomeFirstResponder()
                    }
                }
                
            }
        }
        
        return false
    }
    
    private func deleteText(in textField: UITextField) {
        secureEntryData[textField.tag - 1] = ""
        textField.text = ""
        textField.becomeFirstResponder()
        calculateEnteredOTPSTring(isDeleted: true, isLastCharracter: textField.tag == fieldsCount )
    }
}

