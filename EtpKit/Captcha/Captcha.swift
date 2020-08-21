//
//  Captcha.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit



@IBDesignable
class Captcha : ETPView  {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    private lazy var imageView :UIImageView = {
        var view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var textField :UITextField = {
        var view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button :UIButton = {
        var view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private func setupUI(){
        self.addSubview(imageView)
        self.addSubview(textField)
        self.addSubview(button)
        
        imageView.contentMode = .scaleAspectFit
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor,multiplier: 0.5).isActive = true
        

        
        textField.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: heightAnchor,multiplier: 0.5).isActive = true
        
        textField.placeholder = "Captcha"
     
        textField.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
       
     
               
        
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        
        button.contentEdgeInsets.left = 8;
        button.contentEdgeInsets.right = 8;
       
        button.onClick {
            self.refreshHandler?()
        }
        
    
        
        cornerRadius = 8
        borderWidth = 1
        borderColor = .red
        
    }
    
    private var refreshHandler: (() -> Void?)? = nil
    func refreshCallback(_ handler: @escaping () -> Void){
        self.refreshHandler = handler
    }
    
    func setCaptchaBase64(captcha: String) {
        DispatchQueue.main.sync {
            self.imageView.image = self.base64StringToUIImage(base64String:captcha)
        }
    }
    func getCaptcha() -> String {
        return textField.text ?? ""
     }
    func base64StringToUIImage(base64String:String?) -> UIImage? {
        if let temp = base64String{
            let dataDecoded : Data = Data(base64Encoded: temp, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }else {
            return #imageLiteral(resourceName: "no_image_found")
        }
    }
    
    
}
