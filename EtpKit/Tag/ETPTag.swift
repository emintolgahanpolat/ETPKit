//
//  ETPTag.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 15.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

@IBDesignable
class ETPTag :UIView{

    lazy var titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = textColor
        return lbl
    }()
    

    
    @IBInspectable var text: String! {
        set {
            titleLabel.text = newValue;
        }
        get {
            return titleLabel.text
        }
    }
    @IBInspectable var textColor: UIColor = .black  {
        didSet{
            titleLabel.textColor = textColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        

        addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -8).isActive = true
        
       
       
        
    }
   
   
}
extension ETPTag{
    
    
    
    
       @IBInspectable var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
               layer.cornerRadius = newValue < frame.height / 2 ? newValue : frame.height / 2
              
                
            }
        }
       
       @IBInspectable
       var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }
       
       @IBInspectable
       var borderColor: UIColor? {
           get {
               if let color = layer.borderColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               layer.borderColor = newValue?.cgColor
           }
       }
       
       @IBInspectable
       var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue
           }
       }
       
       @IBInspectable
       var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
       @IBInspectable
       var shadowOffset: CGSize {
           get {
               return layer.shadowOffset
           }
           set {
               layer.shadowOffset = newValue
           }
       }
       
       @IBInspectable
       var shadowColor: UIColor? {
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               layer.shadowColor = newValue?.cgColor
           }
       }
}
